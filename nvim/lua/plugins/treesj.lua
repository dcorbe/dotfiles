-- TreeSJ (split/join)
require("treesj").setup({
  use_default_keymaps = false,
  max_join_length = 120000,
})

local map = vim.keymap.set
map("n", "<leader>m", function() require("treesj").toggle() end, { desc = "Toggle split/join" })
map("n", "<leader>j", function() require("treesj").join() end, { desc = "Join lines" })
map("n", "<leader>M", function() require("treesj").toggle({ split = { recursive = true } }) end, { desc = "Toggle recursive" })
