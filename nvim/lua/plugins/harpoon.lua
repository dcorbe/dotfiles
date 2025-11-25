return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
        vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })
        vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end, { desc = "Harpoon 6" })
        vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end, { desc = "Harpoon 7" })
        vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end, { desc = "Harpoon 8" })
        vim.keymap.set("n", "<leader>h9", function() harpoon:list():select(9) end, { desc = "Harpoon 9" })

        vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
    end,
}
