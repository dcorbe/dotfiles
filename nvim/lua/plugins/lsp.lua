return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Global on_attach for all LSP servers
    local on_attach = function(client, bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.keymap.set('n', '<leader>ih', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { buffer = bufnr, desc = 'Toggle inlay hints' })
      end
    end

    -- NOTE: Rust is handled by rustaceanvim in rust.lua - DO NOT configure here

    -- Lua
    vim.lsp.config('lua_ls', {
      cmd = { 'lua-language-server' },
      root_markers = { '.luarc.json', '.stylua.toml' },
      capabilities = capabilities,
      on_attach = on_attach,
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
      on_attach = on_attach,
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
      on_attach = on_attach,
    })

    -- ESLint
    vim.lsp.config('eslint', {
      cmd = { 'vscode-eslint-language-server', '--stdio' },
      root_markers = { '.eslintrc', '.eslintrc.js', 'eslint.config.js' },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Python
    vim.lsp.config('basedpyright', {
      cmd = { 'basedpyright-langserver', '--stdio' },
      root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt' },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = 'standard',
            autoImportCompletions = true,
            inlayHints = {
              variableTypes = true,
              functionReturnTypes = true,
              callArgumentNames = true,
              pytestParameters = true,
            },
          },
        },
      },
    })

    vim.lsp.config('ruff', {
      cmd = { 'ruff', 'server' },
      root_markers = { 'pyproject.toml', 'ruff.toml' },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- C/C++
    vim.lsp.config('clangd', {
      cmd = { 'clangd' },
      root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- Enable non-Rust servers (Rust handled by rustaceanvim)
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('vtsls')
    vim.lsp.enable('tailwindcss')
    vim.lsp.enable('eslint')
    vim.lsp.enable('basedpyright')
    vim.lsp.enable('ruff')
    vim.lsp.enable('clangd')

    -- Format Python on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.py',
      callback = function()
        vim.lsp.buf.format({ name = 'ruff', timeout_ms = 1000 })
      end,
    })
  end,
}
