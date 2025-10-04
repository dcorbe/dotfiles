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
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup("plugins")

-- Setup lazy.nvim - PLUGINS in first argument
require("lazy").setup({
    {
        'simrat39/rust-tools.nvim',
    },
    -- Completions
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/vim-vsnip' },
    {
        'cohama/lexima.vim',
    },
    {
    },
}, 

-- LSP Capabilities for completions
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Rust tools
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(client, bufnr)
            -- Disable LSP semantic tokens in favor of Treesitter highlighting
            client.server_capabilities.semanticTokensProvider = nil
            
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })

            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            
            -- Buffer local mappings
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr })
        end,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
                inlayHints = {
                    enable = true
                },
                -- Disable semantic highlighting from rust-analyzer
                semanticHighlighting = {
                    enable = false,
                    operator = false,
                    punctuation = false,
                }
            }
        }
    },
})

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    -- Installed sources:
    sources = {
        { name = 'path' },                              -- file paths
        { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
        { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
        { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer', keyword_length = 2 },        -- source current buffer
        { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
        { name = 'calc'},                               -- source for math calculation
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon ={
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "rust", "toml", "typescript", "tsx", "javascript" },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    icons_enable = true,
    indent = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    -- Enable folding with Treesitter
    fold = {
        enable = true
    }
}

-- Better folding configuration using Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldnestmax = 10       -- Prevent too many nested folds
vim.opt.foldenable = true      -- Enable folding
vim.opt.foldlevelstart = 99    -- Start with all folds open
vim.opt.foldminlines = 1       -- Allow folding even small blocks

-- Enhanced folding for React/TypeScript files
local function setup_tsx_folding()
    local filetype = vim.bo.filetype
    if filetype == "typescript" or filetype == "typescriptreact" or filetype == "javascript" or filetype == "javascriptreact" then
        -- Set more aggressive folding for JSX/TSX files
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
        
        -- Create custom fold text function that handles return statements better
        vim.opt_local.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend))]]
    end
end

-- Set up autocmd to apply these settings when opening relevant files
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.ts", "*.tsx", "*.jsx", "*.js"},
    callback = setup_tsx_folding
})

-- Key mappings for folding
vim.keymap.set('n', 'zf', function()
    -- Toggle fold under cursor
    local line = vim.fn.line('.')
    if vim.fn.foldclosed(line) == -1 then
        vim.cmd('normal! zc')
    else
        vim.cmd('normal! zo')
    end
end, { noremap = true, silent = true, desc = "Toggle fold under cursor" })

-- Additional folding keymaps for React components
vim.keymap.set('n', '<leader>fr', function()
    -- Find and fold the nearest return statement
    local line = vim.fn.search('return\\s*(', 'bcnW')
    if line > 0 then
        vim.fn.cursor(line, 1)
        vim.cmd('normal! zc')
    end
end, { noremap = true, silent = true, desc = "Fold nearest return statement" })

-- This gives us the ability to fold return statements in typescript 
vim.keymap.set('n', '<leader>fR', function()
    -- Save cursor position
    local cursor_pos = vim.fn.getcurpos()
    
    -- Move to start of file
    vim.cmd('normal! gg')
    
    -- Find and fold all return statements
    local found = true
    while found do
        local line = vim.fn.search('return\\s*(', 'W')
        if line > 0 then
            vim.fn.cursor(line, 1)
            vim.cmd('normal! zc')
        else
            found = false
        end
    end
    
    -- Restore cursor position
    vim.fn.setpos('.', cursor_pos)
end, { noremap = true, silent = true, desc = "Fold all return statements" })

-- Disable the blue/cyan highlighting for diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = false,  -- This disables the underlining which is likely causing the color change
  update_in_insert = false,
})


-- Configure error list format using quickfix list
vim.keymap.set('n', '<leader>e', function()
    vim.diagnostic.setloclist()
    vim.cmd('copen')
end, { noremap = true, silent = true, desc = "Open error list" })


vim.keymap.set('n', '<leader>r', function()
    vim.diagnostic.setqflist()
    vim.cmd('copen')
end, { noremap = true, silent = true, desc = "Open error list" })

-- This comes last
vim.cmd[[highlight Normal guibg=#22212B ctermbg=235]]
vim.opt.cursorline = true
vim.cmd[[highlight CursorLineNr guifg=#ff79c6 ctermfg=212]]
vim.cmd[[highlight CursorLine guibg=NONE ctermbg=NONE]]


