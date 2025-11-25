return {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
        -- Show marks in sign column
        default_mappings = true,
        -- Builtin marks to show (uppercase = global, lowercase = buffer-local)
        builtin_marks = { ".", "<", ">", "^" },
        -- Cycle through marks with ]` and [`
        cyclic = true,
        -- Auto-refresh marks
        force_write_shada = false,
        -- Bookmark groups (use m1, m2, etc. to set, '1, '2 to jump)
        bookmark_0 = {
            sign = "⚑",
            virt_text = "",
        },
        mappings = {},
    },
}
