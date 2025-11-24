return {
    "gbprod/yanky.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        { "y", mode = { "n", "x" } },
        { "p", mode = { "n", "x" } },
        { "P", mode = { "n", "x" } },
        { "gp", mode = { "n", "x" } },
        { "gP", mode = { "n", "x" } },
        { "<leader>p", desc = "Yank history" },
        { "<c-p>", mode = { "n" } },
        { "<c-n>", mode = { "n" } },
    },
    config = function()
        local yanky = require("yanky")
        local telescope = require("telescope")

        -- Configure yanky
        yanky.setup({
            ring = {
                history_length = 100,
                storage = "shada",
                sync_with_numbered_registers = true,
                cancel_event = "update",
                ignore_registers = { "_" },
            },
            picker = {
                telescope = {
                    use_default_mappings = true,
                    mappings = nil,
                },
            },
            system_clipboard = {
                sync_with_ring = true,
            },
            highlight = {
                on_put = true,
                on_yank = true,
                timer = 300,
            },
            preserve_cursor_position = {
                enabled = true,
            },
        })

        -- Load Telescope extension
        telescope.load_extension("yank_history")

        -- Set up keymaps
        local map = vim.keymap.set

        -- Basic yank/put operations
        map({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank" })
        map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put after" })
        map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put before" })
        map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put after and leave cursor after" })
        map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put before and leave cursor after" })

        -- Cycle through yank history
        map("n", "<c-p>", "<Plug>(YankyCycleForward)", { desc = "Cycle forward through yank history" })
        map("n", "<c-n>", "<Plug>(YankyCycleBackward)", { desc = "Cycle backward through yank history" })

        -- Open yank history in Telescope
        map("n", "<leader>p", function()
            telescope.extensions.yank_history.yank_history({})
        end, { desc = "Yank history" })
    end,
}
