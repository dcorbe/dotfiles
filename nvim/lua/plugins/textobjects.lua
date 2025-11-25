return {
    -- Treesitter text objects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["ai"] = "@conditional.outer",
                            ["ii"] = "@conditional.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]a"] = "@parameter.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[a"] = "@parameter.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>sn"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>sp"] = "@parameter.inner",
                        },
                    },
                },
            })
        end,
    },

    -- Enhanced a/i text objects with count support
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    -- Use treesitter for function/class (integrates with ts-textobjects)
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                },
            }
        end,
    },

    -- Various specialized text objects
    {
        "chrisgrieser/nvim-various-textobjs",
        event = "VeryLazy",
        opts = {
            keymaps = { useDefaults = false },
        },
        config = function(_, opts)
            require("various-textobjs").setup(opts)
            local map = vim.keymap.set
            local textobjs = require("various-textobjs")
            -- Subword (camelCase/snake_case parts)
            map({ "o", "x" }, "aS", function() textobjs.subword("outer") end, { desc = "outer subword" })
            map({ "o", "x" }, "iS", function() textobjs.subword("inner") end, { desc = "inner subword" })
            -- URL
            map({ "o", "x" }, "U", function() textobjs.url() end, { desc = "URL" })
            -- Number
            map({ "o", "x" }, "an", function() textobjs.number("outer") end, { desc = "outer number" })
            map({ "o", "x" }, "in", function() textobjs.number("inner") end, { desc = "inner number" })
            -- Value in key-value pair
            map({ "o", "x" }, "av", function() textobjs.value("outer") end, { desc = "outer value" })
            map({ "o", "x" }, "iv", function() textobjs.value("inner") end, { desc = "inner value" })
            -- Key in key-value pair
            map({ "o", "x" }, "ak", function() textobjs.key("outer") end, { desc = "outer key" })
            map({ "o", "x" }, "ik", function() textobjs.key("inner") end, { desc = "inner key" })
            -- Entire indentation block
            map({ "o", "x" }, "aI", function() textobjs.indentation("outer", "outer") end, { desc = "outer indentation" })
            map({ "o", "x" }, "iI", function() textobjs.indentation("inner", "inner") end, { desc = "inner indentation" })
        end,
    },
}
