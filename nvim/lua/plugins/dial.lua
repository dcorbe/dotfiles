return {
    "monaqa/dial.nvim",
    keys = {
        { "<C-a>", mode = { "n", "v" } },
        { "<C-x>", mode = { "n", "v" } },
        { "g<C-a>", mode = { "v" } },
        { "g<C-x>", mode = { "v" } },
    },
    config = function()
        local augend = require("dial.augend")
        local config = require("dial.config")

        -- Define custom augend groups
        config.augends:register_group({
            default = {
                -- Numbers
                augend.integer.alias.decimal,   -- 0, 1, 2, 3...
                augend.integer.alias.hex,       -- 0x00, 0x01, 0xff...
                augend.integer.alias.octal,     -- 0o00, 0o01, 0o07...
                augend.integer.alias.binary,    -- 0b0000, 0b0001...
                augend.constant.alias.bool,     -- true/false

                -- Dates
                augend.date.alias["%Y/%m/%d"],  -- 2024/01/15
                augend.date.alias["%Y-%m-%d"],  -- 2024-01-15
                augend.date.alias["%m/%d/%Y"],  -- 01/15/2024
                augend.date.alias["%H:%M:%S"],  -- 14:30:00
                augend.date.alias["%H:%M"],     -- 14:30

                -- Days of week
                augend.constant.new({
                    elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" },
                    word = true,
                    cyclic = true,
                }),

                -- Months
                augend.constant.new({
                    elements = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" },
                    word = true,
                    cyclic = true,
                }),

                -- Logical operators
                augend.constant.new({
                    elements = { "&&", "||" },
                    word = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "and", "or" },
                    word = true,
                    cyclic = true,
                }),

                -- Comparison operators
                augend.constant.new({
                    elements = { "==", "!=" },
                    word = false,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "===", "!==" },
                    word = false,
                    cyclic = true,
                }),

                -- Common constants
                augend.constant.new({
                    elements = { "yes", "no" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "on", "off" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "true", "false" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "True", "False" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "enable", "disable" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "enabled", "disabled" },
                    word = true,
                    cyclic = true,
                }),

                -- Git conflict markers (increment/decrement through conflict sections)
                augend.constant.new({
                    elements = { "<<<<<<< HEAD", "=======", ">>>>>>>" },
                    word = false,
                    cyclic = true,
                }),

                -- Common pairs
                augend.constant.new({
                    elements = { "first", "second", "third", "fourth", "fifth" },
                    word = true,
                    cyclic = false,
                }),
                augend.constant.new({
                    elements = { "start", "end" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "left", "right" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "up", "down" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "top", "bottom" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "before", "after" },
                    word = true,
                    cyclic = true,
                }),
                augend.constant.new({
                    elements = { "min", "max" },
                    word = true,
                    cyclic = true,
                }),
            },

            -- Visual mode group (supports sequential incrementing)
            visual = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.integer.alias.octal,
                augend.integer.alias.binary,
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%Y-%m-%d"],
                augend.date.alias["%m/%d/%Y"],
                augend.constant.alias.alpha,    -- a, b, c...
                augend.constant.alias.Alpha,    -- A, B, C...
            },
        })

        -- Set up keymaps
        local map = vim.keymap.set
        local dial_map = require("dial.map")

        -- Normal mode
        map("n", "<C-a>", function()
            dial_map.manipulate("increment", "normal")
        end, { desc = "Increment" })
        map("n", "<C-x>", function()
            dial_map.manipulate("decrement", "normal")
        end, { desc = "Decrement" })

        -- Visual mode (sequential increment/decrement)
        map("v", "<C-a>", function()
            dial_map.manipulate("increment", "visual")
        end, { desc = "Increment (sequential)" })
        map("v", "<C-x>", function()
            dial_map.manipulate("decrement", "visual")
        end, { desc = "Decrement (sequential)" })

        -- Visual mode with g prefix (same increment for all)
        map("v", "g<C-a>", function()
            dial_map.manipulate("increment", "gnormal")
        end, { desc = "Increment (same for all)" })
        map("v", "g<C-x>", function()
            dial_map.manipulate("decrement", "gnormal")
        end, { desc = "Decrement (same for all)" })
    end,
}
