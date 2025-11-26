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
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>h", group = "harpoon" },
            { "<leader>n", group = "narrow" },
            { "<leader>s", group = "swap" },
            { "<leader>t", group = "toggle/test" },
            { "<leader>d", group = "debug/db" },
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
