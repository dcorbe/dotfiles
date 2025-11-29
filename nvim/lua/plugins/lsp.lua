return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- NOTE: Rust is handled by rustaceanvim in rust.lua - DO NOT configure here

    -- Lua
    vim.lsp.config('lua_ls', {
      cmd = { 'lua-language-server' },
      root_markers = { '.luarc.json', '.stylua.toml' },
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        },
      },
    })

    -- TypeScript/JavaScript
    vim.lsp.config('vtsls', {
      cmd = { 'vtsls', '--stdio' },
      root_markers = { 'package.json', 'tsconfig.json' },
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            parameterNames = { enabled = 'all' },
            parameterTypes = { enabled = true },
            variableTypes = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
          },
        },
      },
    })

    -- Tailwind
    vim.lsp.config('tailwindcss', {
      cmd = { 'tailwindcss-language-server', '--stdio' },
      root_markers = { 'tailwind.config.js', 'tailwind.config.ts' },
      capabilities = capabilities,
    })

    -- ESLint
    vim.lsp.config('eslint', {
      cmd = { 'vscode-eslint-language-server', '--stdio' },
      root_markers = { '.eslintrc', '.eslintrc.js', 'eslint.config.js' },
      capabilities = capabilities,
    })

    -- Python
    vim.lsp.config('basedpyright', {
      cmd = { 'basedpyright-langserver', '--stdio' },
      root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt' },
      capabilities = capabilities,
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = 'standard',
            autoImportCompletions = true,
          },
        },
      },
    })

    vim.lsp.config('ruff', {
      cmd = { 'ruff', 'server' },
      root_markers = { 'pyproject.toml', 'ruff.toml' },
      capabilities = capabilities,
    })

    -- Enable non-Rust servers (Rust handled by rustaceanvim)
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('vtsls')
    vim.lsp.enable('tailwindcss')
    vim.lsp.enable('eslint')
    vim.lsp.enable('basedpyright')
    vim.lsp.enable('ruff')

    -- Format Python on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.py',
      callback = function()
        vim.lsp.buf.format({ name = 'ruff', timeout_ms = 1000 })
      end,
    })
  end,
}
