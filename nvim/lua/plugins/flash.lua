return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        -- Labels to use for jump targets
        labels = "asdfghjklqwertyuiopzxcvbnm",
        -- Search settings
        search = {
            multi_window = true,
            forward = true,
            wrap = true,
            mode = "exact", -- exact, search, fuzzy
        },
        -- Jump settings
        jump = {
            jumplist = true,
            pos = "start",
            history = false,
            register = false,
            nohlsearch = false,
            autojump = false,
        },
        -- Label settings
        label = {
            uppercase = true,
            exclude = "",
            current = true,
            after = true,
            before = false,
            style = "overlay",
            reuse = "lowercase",
        },
        -- Highlight settings
        highlight = {
            backdrop = true,
            matches = true,
            priority = 5000,
            groups = {
                match = "FlashMatch",
                current = "FlashCurrent",
                backdrop = "FlashBackdrop",
                label = "FlashLabel",
            },
        },
        -- Action modes
        modes = {
            -- Flash search
            search = {
                enabled = true,
            },
            -- Character search (f/t/F/T)
            char = {
                enabled = true,
                keys = { "f", "F", "t", "T", ";", "," },
                search = { wrap = false },
                highlight = { backdrop = true },
                jump = { register = false },
                multi_line = true,
                label = { exclude = "hjkliardc" },
                jump_labels = true,
            },
            -- Treesitter search
            treesitter = {
                labels = "abcdefghijklmnopqrstuvwxyz",
                jump = { pos = "range" },
                search = { incremental = false },
                label = { before = true, after = true, style = "inline" },
                highlight = {
                    backdrop = false,
                    matches = false,
                },
            },
        },
    },
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    },
}
