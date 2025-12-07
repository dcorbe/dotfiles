-- Zen Mode
require("zen-mode").setup({
  window = {
    backdrop = 0.95,
    width = 0.4,
    height = 1,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = "0",
      list = false,
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,
      showcmd = false,
      laststatus = 0,
    },
    twilight = { enabled = true },
    gitsigns = { enabled = false },
    tmux = { enabled = true },
    kitty = { enabled = false, font = "+4" },
    alacritty = { enabled = false, font = "14" },
    wezterm = { enabled = false, font = "+4" },
  },
  on_open = function(win) end,
  on_close = function() end,
})

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle Zen Mode" })
