-- Autopairs
require("nvim-autopairs").setup({
  ignored_next_char = "[%w%.]",
  check_ts = true,
  ts_config = {
    lua = { "string", "comment" },
    javascript = { "string", "template_string", "comment" },
    typescript = { "string", "template_string", "comment" },
    rust = { "string_literal", "char_literal", "line_comment", "block_comment" },
    python = { "string", "comment" },
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
})
