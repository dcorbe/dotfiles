-- Cellular Automaton (fun animations)
local matrix_rain = require("animations.matrix_rain")
require("cellular-automaton").register_animation(matrix_rain)

local map = vim.keymap.set
map("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", { desc = "Make It Rain" })
map("n", "<leader>fms", "<cmd>CellularAutomaton scramble<cr>", { desc = "Scramble" })
map("n", "<leader>fmg", "<cmd>CellularAutomaton game_of_life<cr>", { desc = "Game of Life" })
map("n", "<leader>fmx", "<cmd>CellularAutomaton matrix_rain<cr>", { desc = "Matrix Rain" })
