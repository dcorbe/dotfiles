-- Colorizer
require("colorizer").setup({
  filetypes = {
    "*",
    css = { rgb_fn = true },
    html = { names = true },
    javascript = { tailwind = true },
    typescript = { tailwind = true },
    javascriptreact = { tailwind = true },
    typescriptreact = { tailwind = true },
  },
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    names = false,
    RRGGBBAA = true,
    AARRGGBB = false,
    rgb_fn = false,
    hsl_fn = false,
    css = false,
    css_fn = false,
    mode = "background",
    tailwind = false,
    sass = { enable = false, parsers = { "css" } },
    virtualtext = "■",
    always_update = false,
  },
  buftypes = {},
})
