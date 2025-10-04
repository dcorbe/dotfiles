_G.vim = vim

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  lazy = false,
  config = function()
    require('toggleterm').setup({
      -- Replace the current window with terminal
      open_mapping = [[<c-\>]],  -- Ctrl+\ to toggle terminal
      direction = 'float',         -- Replace current window
      insert_mappings = true,    -- Whether terminal opens in insert mode
      close_on_exit = true,      -- Close terminal window when process exits
      shading_factor = 0,        -- No background shading
      shell = vim.o.shell,       -- Use your default shell

      -- Optional: size customization
      size = function(term)
        if term.direction == "horizontal" then
          return 15              -- 15 rows height if horizontal
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4  -- 40% of screen width if vertical
        end
      end,

      -- Terminal window mappings
      on_open = function(term)
        vim.cmd("startinsert!")
        -- Optional: disable line numbers in terminal
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false

        -- Add custom keybindings for terminal window
        local opts = {buffer = term.bufnr}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)  -- Escape to normal mode
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)  -- Navigate windows
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end,
    })

    -- Create additional keymaps if needed
    vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=window<CR>',
      {noremap = true, silent = true, desc = "Toggle terminal in current window"})
  end,
}

