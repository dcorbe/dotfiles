-- Neogit
require("neogit").setup({
  disable_insert_on_commit = true,
  integrations = {
    diffview = true,
    fzf_lua = true,
  },
  sections = {
    stashes = {
      folded = true,
    },
    recent = {
      folded = true,
    },
  },
})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>gg", function() require("neogit").open() end, { desc = "Open Neogit" })
map("n", "<leader>gc", function() require("neogit").open({ "commit" }) end, { desc = "Neogit Commit" })
