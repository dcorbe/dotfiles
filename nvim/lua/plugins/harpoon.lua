-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

local map = vim.keymap.set
map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
map("n", "<leader>h5", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })
map("n", "<leader>h6", function() harpoon:list():select(6) end, { desc = "Harpoon 6" })
map("n", "<leader>h7", function() harpoon:list():select(7) end, { desc = "Harpoon 7" })
map("n", "<leader>h8", function() harpoon:list():select(8) end, { desc = "Harpoon 8" })
map("n", "<leader>h9", function() harpoon:list():select(9) end, { desc = "Harpoon 9" })

map("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
map("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
