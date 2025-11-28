return {
    "jake-stewart/diff.nvim",
    keys = {
        {
            "<leader>gD",
            function()
                require("diff").diff()
            end,
            mode = "v",
            desc = "Diff Selection",
        },
    },
    opts = {},
}
