return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "ibhagwan/fzf-lua",
    },
    cmd = "Neogit",
    keys = {
        {
            "<leader>gg",
            function()
                require("neogit").open()
            end,
            desc = "Open Neogit",
        },
        {
            "<leader>gc",
            function()
                require("neogit").open({ "commit" })
            end,
            desc = "Neogit Commit",
        },
    },
    opts = {
        -- Use default keybindings (they're good!)
        -- Press ? inside neogit to see all available commands
        integrations = {
            diffview = true,
            fzf_lua = true,
        },
        -- Simplified sections config - just set what should be hidden by default
        sections = {
            stashes = {
                folded = true,
            },
            recent = {
                folded = true,
            },
        },
    },
}
