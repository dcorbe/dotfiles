return {
    "Eandrju/cellular-automaton.nvim",
    lazy = false,  -- Force load on startup
    priority = 50,  -- Load after core plugins
    config = function()
        local matrix_rain = require("animations.matrix_rain")
        require("cellular-automaton").register_animation(matrix_rain)
    end,
    keys = {
        {
            "<leader>fml",
            "<cmd>CellularAutomaton make_it_rain<cr>",
            desc = "Make It Rain",
        },
        {
            "<leader>fms",
            "<cmd>CellularAutomaton scramble<cr>",
            desc = "Scramble",
        },
        {
            "<leader>fmg",
            "<cmd>CellularAutomaton game_of_life<cr>",
            desc = "Game of Life",
        },
        {
            "<leader>fmx",
            "<cmd>CellularAutomaton matrix_rain<cr>",
            desc = "Matrix Rain",
        },
    },
}
