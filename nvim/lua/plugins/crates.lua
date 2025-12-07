-- Crates.nvim (Rust Cargo.toml helper)
require("crates").setup({
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
})

-- Keymaps
local map = vim.keymap.set
local crates = require("crates")

map("n", "<leader>ct", function() crates.toggle() end, { desc = "Toggle crates info" })
map("n", "<leader>cr", function() crates.reload() end, { desc = "Reload crates" })
map("n", "<leader>cv", function() crates.show_versions_popup() end, { desc = "Show versions" })
map("n", "<leader>cf", function() crates.show_features_popup() end, { desc = "Show features" })
map("n", "<leader>cd", function() crates.show_dependencies_popup() end, { desc = "Show dependencies" })
map("n", "<leader>cu", function() crates.update_crate() end, { desc = "Update crate" })
map("n", "<leader>cU", function() crates.upgrade_crate() end, { desc = "Upgrade crate" })
map("n", "<leader>ca", function() crates.update_all_crates() end, { desc = "Update all crates" })
map("n", "<leader>cA", function() crates.upgrade_all_crates() end, { desc = "Upgrade all crates" })
map("n", "<leader>cH", function() crates.open_homepage() end, { desc = "Open homepage" })
map("n", "<leader>cR", function() crates.open_repository() end, { desc = "Open repository" })
map("n", "<leader>cD", function() crates.open_documentation() end, { desc = "Open docs.rs" })
map("n", "<leader>cC", function() crates.open_crates_io() end, { desc = "Open crates.io" })
