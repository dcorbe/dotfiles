-- nvim-treesitter v1.0+: configs module removed, nvim handles highlighting natively
require('nvim-treesitter').setup()

local parsers = { "lua", "rust", "toml", "typescript", "tsx", "javascript", "python" }
local config = require('nvim-treesitter.config')
local installed = {}
for _, p in ipairs(config.get_installed('parsers')) do
  installed[p] = true
end

local missing = vim.tbl_filter(function(p) return not installed[p] end, parsers)
if #missing > 0 then
  require('nvim-treesitter.install').install(missing)
end

-- treesitter-based indent
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end
})

-- treesitter-based folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldenable = false
