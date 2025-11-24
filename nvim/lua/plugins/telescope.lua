-- plugins/telescope.lua:
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('telescope').setup({
            defaults = {
                -- Borderless design
                borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },

                -- Layout configuration
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.6,
                        width = 0.9,
                        height = 0.8,
                    },
                },

                -- Sorting
                sorting_strategy = "ascending",

                -- Clean UI
                prompt_prefix = "  ",
                selection_caret = " ",
                entry_prefix = "  ",

                -- Performance
                file_ignore_patterns = { "^.git/", "node_modules" },
            },
        })
    end,
}
