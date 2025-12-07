-- Render markdown
require("render-markdown").setup({
  heading = {
    icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
  },
  code = {
    sign = false,
    width = "block",
    right_pad = 1,
  },
  checkbox = {
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰄵 " },
  },
})
