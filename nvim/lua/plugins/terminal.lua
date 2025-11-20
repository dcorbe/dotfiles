-- lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Size can be a number or function
      size = function(term)
        if term.direction == "horizontal" then
          return 15  -- 15 lines height for horizontal split
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4  -- 40% of screen width for vertical split
        end
      end,
      open_mapping = [[<c-\>]],  -- Key to toggle terminal visibility
      direction = 'float',  -- Default terminal direction ('float', 'horizontal', 'vertical', 'tab')
      shade_terminals = true,  -- Apply darker background to terminals
      start_in_insert = true,  -- Start terminal in insert mode
      persist_size = true,  -- Remember terminal size
      close_on_exit = true,  -- Close terminal when process exits
    })

    -- Define custom key mappings for different terminal layouts
    vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal size=15<CR>", {noremap = true, silent = true})
    vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical size=60<CR>", {noremap = true, silent = true})
    
    -- Open terminal in the current file's directory
    vim.keymap.set("n", "<leader>td", ":ToggleTerm dir=%:p:h<CR>", {noremap = true, silent = true})
    
    -- Terminal with specific command (e.g., for Rust)
    vim.keymap.set("n", "<leader>cr", function()
      local term = require("toggleterm.terminal").Terminal:new({
        cmd = "cargo run",
        direction = "horizontal",
        hidden = true,
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
      })
      term:toggle()
    end, {noremap = true, silent = true})
    
    -- Function to toggle multiple terminal instances with different indices
    local function create_terminal_toggle(idx, cmd, direction)
      return function()
        local term = require("toggleterm.terminal").Terminal:new({
          count = idx,
          cmd = cmd,
          direction = direction or "horizontal",
          hidden = true,
        })
        term:toggle()
      end
    end
    
    -- Example of creating different terminal commands
    vim.keymap.set("n", "<leader>t1", create_terminal_toggle(1, nil, "horizontal"), {noremap = true, silent = true})
    vim.keymap.set("n", "<leader>t2", create_terminal_toggle(2, "htop", "float"), {noremap = true, silent = true})
    vim.keymap.set("n", "<leader>t3", create_terminal_toggle(3, nil, "vertical"), {noremap = true, silent = true})
  end,
}
