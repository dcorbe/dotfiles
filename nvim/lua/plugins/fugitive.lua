-- Fugitive (Git)
-- No setup needed, just keymaps
local map = vim.keymap.set
map("n", "<leader>gX", "<cmd>silent Git rm --cached %<cr>", { desc = "Untrack file (keep on disk)" })
map("n", "<leader>gB", "<cmd>Git blame<cr>", { desc = "Blame file" })
map("n", "<leader>gl", "<cmd>Git log<cr>", { desc = "Git log" })
