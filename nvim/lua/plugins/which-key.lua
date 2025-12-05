return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 1200,
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        spec = {
            { "<leader>c", group = "crates" },
            { "<leader>d", group = "debug/db" },
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>gt", group = "toggle" },
            { "<leader>h", group = "harpoon" },
            { "<leader>j", group = "java" },
            { "<leader>n", group = "narrow" },
            { "<leader>s", group = "swap" },
            { "<leader>t", group = "toggle/test" },
            { "<leader>x", group = "trouble" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer local keymaps",
        },
        {
            "<leader><leader>",
            function()
                require("which-key").show()
            end,
            desc = "Show all keybinds",
        },
    },
}
