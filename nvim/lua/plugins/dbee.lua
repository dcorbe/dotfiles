-- Dbee (database explorer)
require("dbee").setup({})

vim.keymap.set("n", "<leader>DB", function() require("dbee").toggle() end, { desc = "Toggle DB explorer" })
