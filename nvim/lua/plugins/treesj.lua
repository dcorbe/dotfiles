return {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
        { "<leader>m", function() require("treesj").toggle() end, desc = "Toggle split/join" },
        { "<leader>j", function() require("treesj").join() end, desc = "Join lines" },
        { "<leader>M", function() require("treesj").toggle({ split = { recursive = true } }) end, desc = "Toggle recursive" },
    },
    opts = {
        use_default_keymaps = false,
        max_join_length = 120000,
    },
}
