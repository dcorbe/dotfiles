-- Comment.nvim
require("Comment").setup({
  padding = true,
  sticky = true,
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  extra = {
    above = 'gcO',
    below = 'gco',
    eol = 'gcA',
  },
})

-- Comment.nvim is unmaintained (last commit 2024-06). Its ft.calculate
-- assumes vim.treesitter.get_parser throws when no parser exists, but
-- since Neovim 0.12 it returns nil instead. The nil then crashes inside
-- ft.contains and surfaces as "[Comment.nvim] nil". Take the same
-- fallback path the plugin uses for the throw case.
local ft = require("Comment.ft")
local calculate = ft.calculate
ft.calculate = function(ctx)
  if not vim.treesitter.get_parser(0, nil, { error = false }) then
    return ft.get(vim.bo.filetype, ctx.ctype)
  end
  return calculate(ctx)
end
