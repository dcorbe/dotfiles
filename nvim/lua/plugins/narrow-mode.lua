-- lua/plugins/narrow-mode.lua
-- Standalone narrow mode: focus on a text region in a scratch buffer

return {
    dir = vim.fn.stdpath("config") .. "/lua",
    name = "narrow-mode",
    config = function()
        require("narrow-mode").setup({
            -- Set to true to auto-enable zen-mode when narrowing
            auto_zen = false,
        })
    end,
    keys = {
        {
            "<leader>n",
            mode = "v",
            ":NarrowMode<CR>",
            desc = "Narrow mode on selection",
            silent = true,
        },
        {
            "<leader>n",
            mode = "n",
            function()
                local narrow = require("narrow-mode")
                if narrow.is_narrow_buffer() then
                    narrow.close()
                else
                    vim.notify("Select text in visual mode first, then press <leader>n", vim.log.levels.INFO)
                end
            end,
            desc = "Close narrow mode",
        },
        {
            "<leader>nf",
            mode = "n",
            function()
                require("narrow-mode").open_current_node()
            end,
            desc = "Narrow current function/class",
        },
    },
    cmd = { "NarrowMode", "NarrowModeClose" },
}
