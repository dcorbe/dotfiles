-- Twilight (dim inactive code)
require("twilight").setup({
  dimming = {
    alpha = 0.25,
    color = { "Normal", "#ffffff" },
    term_bg = "#000000",
    inactive = false,
  },
  context = 0,
  treesitter = true,
  expand = {
    "function",
    "method",
    "table",
    "if_statement",
  },
  exclude = {},
})
