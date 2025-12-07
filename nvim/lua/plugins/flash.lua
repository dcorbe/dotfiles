-- Flash
require("flash").setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = {
    multi_window = true,
    forward = true,
    wrap = true,
    mode = "exact",
  },
  jump = {
    jumplist = true,
    pos = "start",
    history = false,
    register = false,
    nohlsearch = false,
    autojump = false,
  },
  label = {
    uppercase = true,
    exclude = "",
    current = true,
    after = true,
    before = false,
    style = "overlay",
    reuse = "lowercase",
  },
  highlight = {
    backdrop = true,
    matches = true,
    priority = 5000,
    groups = {
      match = "FlashMatch",
      current = "FlashCurrent",
      backdrop = "FlashBackdrop",
      label = "FlashLabel",
    },
  },
  modes = {
    search = {
      enabled = false,
    },
    char = {
      enabled = false,
      keys = { "f", "F", "t", "T", ";", "," },
      search = { wrap = false },
      highlight = { backdrop = true },
      jump = { register = false },
      multi_line = true,
      label = { exclude = "hjkliardc" },
      jump_labels = true,
    },
    treesitter = {
      labels = "abcdefghijklmnopqrstuvwxyz",
      jump = { pos = "range" },
      search = { incremental = false },
      label = { before = true, after = true, style = "inline" },
      highlight = {
        backdrop = false,
        matches = false,
      },
    },
  },
})

-- Keymaps
local map = vim.keymap.set
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "<CR>", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
map("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
map("c", "<leader>/", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
