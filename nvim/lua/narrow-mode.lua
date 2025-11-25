-- lua/narrow-mode.lua
-- Standalone narrow mode: focus on a text region in a scratch buffer

local M = {}

-- State stored per-buffer
-- vim.b.narrow_mode_state = { source_buf, start_line, end_line }

-- Tree-sitter node types for functions
local FUNCTION_TYPES = {
    "function_declaration", "function_definition", "function",
    "method_definition", "method_declaration", "arrow_function",
    "function_expression", "async_function_declaration",
    "function_item",  -- Rust
    "local_function", -- Lua
}

-- Tree-sitter node types for classes/structs
local CLASS_TYPES = {
    "class_declaration", "class_definition", "class",
    "struct_item", "struct_definition",
    "interface_declaration", "impl_item",
    "module_definition",
}

function M.setup(opts)
    opts = opts or {}
    M.config = vim.tbl_deep_extend("force", {
        -- Default width for narrow buffer (nil = full width)
        width = nil,
        -- Whether to enter zen-mode automatically (requires zen-mode.nvim)
        auto_zen = false,
    }, opts)

    -- Create user commands
    vim.api.nvim_create_user_command("NarrowMode", function(cmd_opts)
        if cmd_opts.range == 2 then
            M.open(cmd_opts.line1, cmd_opts.line2)
        else
            vim.notify("Select a range first (use visual mode)", vim.log.levels.WARN)
        end
    end, { range = true, desc = "Open narrow mode for selected lines" })

    vim.api.nvim_create_user_command("NarrowModeClose", function()
        M.close()
    end, { desc = "Close narrow mode and return to source" })
end

function M._sync_to_source(narrow_buf)
    local state = vim.b[narrow_buf].narrow_mode_state
    if not state then
        vim.notify("No narrow mode state found", vim.log.levels.ERROR)
        return
    end

    -- Get the current content of the narrow buffer
    local new_lines = vim.api.nvim_buf_get_lines(narrow_buf, 0, -1, false)

    -- Check if source buffer still exists
    if not vim.api.nvim_buf_is_valid(state.source_buf) then
        vim.notify("Source buffer no longer exists", vim.log.levels.ERROR)
        return
    end

    -- Replace the original lines in the source buffer
    vim.api.nvim_buf_set_lines(
        state.source_buf,
        state.start_line - 1,
        state.end_line,
        false,
        new_lines
    )

    -- Update the end_line in state (in case line count changed)
    local new_end_line = state.start_line + #new_lines - 1
    vim.api.nvim_buf_set_var(narrow_buf, "narrow_mode_state", {
        source_buf = state.source_buf,
        source_file = state.source_file,
        start_line = state.start_line,
        end_line = new_end_line,
    })

    -- Save the source buffer to disk
    vim.api.nvim_buf_call(state.source_buf, function()
        vim.cmd("write")
    end)

    -- Mark narrow buffer as not modified
    vim.bo[narrow_buf].modified = false

    vim.notify(string.format("Synced to %s (lines %d-%d)",
        vim.fn.fnamemodify(state.source_file, ":t"),
        state.start_line,
        new_end_line
    ), vim.log.levels.INFO)
end

function M.open(start_line, end_line)
    -- Validate we're not already in a narrow buffer
    if M.is_narrow_buffer() then
        vim.notify("Already in a narrow buffer", vim.log.levels.WARN)
        return
    end

    -- Warn if source buffer has unsaved changes
    if vim.bo.modified then
        local choice = vim.fn.confirm("Buffer has unsaved changes. Continue?", "&Yes\n&No", 2)
        if choice ~= 1 then
            return
        end
    end

    -- Get source buffer info
    local source_buf = vim.api.nvim_get_current_buf()
    local source_file = vim.api.nvim_buf_get_name(source_buf)
    local filetype = vim.bo[source_buf].filetype

    -- Get the lines from the selection
    local lines = vim.api.nvim_buf_get_lines(source_buf, start_line - 1, end_line, false)

    -- Create a new scratch buffer
    local narrow_buf = vim.api.nvim_create_buf(false, true) -- not listed, scratch

    -- Set buffer options
    vim.bo[narrow_buf].buftype = "acwrite" -- use autocmd for writing (BufWriteCmd)
    vim.bo[narrow_buf].bufhidden = "wipe"
    vim.bo[narrow_buf].swapfile = false
    vim.bo[narrow_buf].filetype = filetype

    -- Set the content
    vim.api.nvim_buf_set_lines(narrow_buf, 0, -1, false, lines)

    -- Give the buffer a name so BufWriteCmd can match it
    vim.api.nvim_buf_set_name(narrow_buf, "narrow://" .. source_file .. ":" .. start_line .. "-" .. end_line)

    -- Define state as a local before using it in autocmds
    local state = {
        source_buf = source_buf,
        source_file = source_file,
        start_line = start_line,
        end_line = end_line,
    }

    -- Store state in the buffer
    vim.api.nvim_buf_set_var(narrow_buf, "narrow_mode_state", state)

    -- Open the buffer in current window
    vim.api.nvim_set_current_buf(narrow_buf)

    -- Mark as not modified (we just loaded it)
    vim.bo[narrow_buf].modified = false

    -- Set up autocmd to sync back on save
    vim.api.nvim_create_autocmd("BufWriteCmd", {
        buffer = narrow_buf,
        callback = function()
            M._sync_to_source(narrow_buf)
        end,
    })

    -- Map ZZ and ZQ for quick close
    vim.keymap.set("n", "ZZ", function()
        M._sync_to_source(narrow_buf)
        M.close()
    end, { buffer = narrow_buf, desc = "Save and close narrow mode" })

    vim.keymap.set("n", "ZQ", function()
        M.close()
    end, { buffer = narrow_buf, desc = "Close narrow mode without saving" })

    -- Intercept :q, :q!, :wq, :wq!, :x by remapping them in this buffer
    local function close_narrow()
        M.close()
    end
    local function save_and_close_narrow()
        M._sync_to_source(narrow_buf)
        M.close()
    end

    -- Buffer-local mappings for command mode
    vim.keymap.set("ca", "q", function()
        if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "q" then
            return "lua require('narrow-mode').close()<CR>"
        end
        return "q"
    end, { buffer = narrow_buf, expr = true })

    vim.keymap.set("ca", "q!", function()
        if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "q!" then
            return "lua require('narrow-mode').close()<CR>"
        end
        return "q!"
    end, { buffer = narrow_buf, expr = true })

    vim.keymap.set("ca", "wq", function()
        if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "wq" then
            return "lua require('narrow-mode')._sync_to_source(vim.api.nvim_get_current_buf()); require('narrow-mode').close()<CR>"
        end
        return "wq"
    end, { buffer = narrow_buf, expr = true })

    vim.keymap.set("ca", "x", function()
        if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "x" then
            return "lua require('narrow-mode')._sync_to_source(vim.api.nvim_get_current_buf()); require('narrow-mode').close()<CR>"
        end
        return "x"
    end, { buffer = narrow_buf, expr = true })

    -- Handle source buffer being deleted
    vim.api.nvim_create_autocmd("BufDelete", {
        buffer = state.source_buf,
        once = true,
        callback = function()
            if vim.api.nvim_buf_is_valid(narrow_buf) then
                vim.api.nvim_buf_set_var(narrow_buf, "narrow_mode_state", nil)
                vim.notify("Source buffer deleted. Narrow buffer is now orphaned.", vim.log.levels.WARN)
            end
        end,
    })

    -- Optionally enable zen-mode
    if M.config.auto_zen then
        local ok, zen = pcall(require, "zen-mode")
        if ok then
            zen.open()
            -- Store that we opened zen-mode so we can close it
            vim.api.nvim_buf_set_var(narrow_buf, "narrow_mode_zen_active", true)
        end
    end

    vim.notify(string.format("Narrowed to lines %d-%d", start_line, end_line), vim.log.levels.INFO)
end

function M.close()
    if not M.is_narrow_buffer() then
        vim.notify("Not in a narrow buffer", vim.log.levels.WARN)
        return
    end

    local state = vim.b.narrow_mode_state
    local narrow_buf = vim.api.nvim_get_current_buf()

    -- If modified, prompt to save
    if vim.bo[narrow_buf].modified then
        local choice = vim.fn.confirm("Narrow buffer modified. Save changes?", "&Yes\n&No\n&Cancel", 1)
        if choice == 1 then
            M._sync_to_source(narrow_buf)
        elseif choice == 3 then
            return -- Cancel close
        end
    end

    -- Close zen-mode if we opened it
    local zen_active = vim.b[narrow_buf].narrow_mode_zen_active
    if zen_active then
        local ok, zen = pcall(require, "zen-mode")
        if ok then
            zen.close()
        end
    end

    -- Switch back to source buffer if it exists
    if state and vim.api.nvim_buf_is_valid(state.source_buf) then
        vim.api.nvim_set_current_buf(state.source_buf)
        -- Jump to the start of the narrowed region
        vim.api.nvim_win_set_cursor(0, { state.start_line, 0 })
    end

    -- Delete the narrow buffer (if it still exists)
    if vim.api.nvim_buf_is_valid(narrow_buf) then
        vim.api.nvim_buf_delete(narrow_buf, { force = true })
    end

    vim.notify("Narrow mode closed", vim.log.levels.INFO)
end

function M.is_narrow_buffer()
    return vim.b.narrow_mode_state ~= nil
end

function M.open_current_node()
    local bufnr = vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(bufnr)

    if not parser then
        vim.notify("No tree-sitter parser for this buffer", vim.log.levels.WARN)
        return
    end

    local tree = parser:parse()[1]
    local root = tree:root()

    local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    cursor_row = cursor_row - 1  -- Convert to 0-indexed

    local node = root:descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

    -- Build combined list of target node types
    local target_types = vim.list_extend(
        vim.list_extend({}, FUNCTION_TYPES),
        CLASS_TYPES
    )

    -- Walk up to find function or class
    while node do
        if vim.tbl_contains(target_types, node:type()) then
            local start_row, _, end_row, _ = node:range()
            -- Convert to 1-indexed
            M.open(start_row + 1, end_row + 1)
            return
        end
        node = node:parent()
    end

    vim.notify("No function or class found at cursor", vim.log.levels.INFO)
end

return M
