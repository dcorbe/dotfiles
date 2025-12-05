vim.loader.enable()

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
opt.spell = false  -- disabled while testing harper-ls
opt.spelllang = 'en_us'
opt.conceallevel = 2

-- Disable spell checking for shell files (too much jargon)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "zsh", "sh", "bash" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.fillchars:append({ vert = ' ' })

-- Add LuaRocks paths for image.nvim
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

require ("config.lazy")

-- Configure diagnostics
vim.g.skip_ts_context_commentstring_module = true
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Make .eml files use the mail filetype
  vim.filetype.add({
    extension = {
      eml = 'mail',
    },
  })

  -- Configure mail-specific settings and auto-reformat
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "mail",
    callback = function()
      vim.opt_local.textwidth = 72      -- Wrap at 72 characters
      vim.opt_local.formatoptions = "tcqwan"  -- Auto-wrap text, handle quotes
      vim.opt_local.comments = "n:>"    -- Handle email quote markers

      -- Auto-reformat only the email body (after headers)
      -- Find the first blank line (RFC 5322 header/body separator)
      local first_blank = vim.fn.search('^$', 'n')
      if first_blank > 0 and first_blank < vim.fn.line('$') then
        -- Format from line after blank line to end of file
        vim.cmd(string.format('normal! %dGgqG', first_blank + 1))
        -- Return cursor to top of file
        vim.cmd('normal! gg')
      else
        -- No blank line found or blank is last line, don't format
        vim.cmd('normal! gg')
      end
    end,
  })



-- This comes last
vim.cmd[[highlight Normal guibg=#22212B ctermbg=235]]
vim.cmd[[highlight CursorLineNr guifg=#ff79c6 ctermfg=212]]
vim.cmd[[highlight CursorLine guibg=NONE ctermbg=NONE]]

-- Keymaps moved to lua/plugins/fzf-lua.lua
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { silent = true, desc = 'Clear search highlighting' })

