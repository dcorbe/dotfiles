-- Tell the linter that vim is a valid global
_G.vim = vim

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.clipboard:append("unnamedplus")
opt.cursorline = true
opt.autoread = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require ("config.lazy")

-- Configure diagnostics
vim.g.skip_ts_context_commentstring_module = true
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
})

vim.keymap.set('n', '<leader>t', ':Neotree toggle<CR>', { silent = true })

-- This comes last
vim.cmd[[highlight Normal guibg=#22212B ctermbg=235]]
vim.cmd[[highlight CursorLineNr guifg=#ff79c6 ctermfg=212]]
vim.cmd[[highlight CursorLine guibg=NONE ctermbg=NONE]]

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', {})

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', {})

