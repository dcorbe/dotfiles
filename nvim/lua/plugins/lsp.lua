-- Shared LSP helpers (used by both lspconfig and rustaceanvim)
local function get_capabilities()
  return require('cmp_nvim_lsp').default_capabilities()
end

local function on_attach(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set('n', '<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { buffer = bufnr, desc = 'Toggle inlay hints' })
  end
end

return {
  -- Main LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = get_capabilities()

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

    -- Go
    vim.lsp.config('gopls', {
      cmd = { 'gopls' },
      root_markers = { 'go.mod', 'go.work', '.git' },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          hints = {
            parameterNames = true,
            assignVariableTypes = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    -- Dockerfile
    vim.lsp.config('dockerls', {
      cmd = { 'docker-langserver', '--stdio' },
      root_markers = { 'Dockerfile', '.git' },
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- YAML (docker-compose, GitHub Actions, k8s, etc.)
    vim.lsp.config('yamlls', {
      cmd = { 'yaml-language-server', '--stdio' },
      root_markers = { '.git' },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        yaml = {
          schemaStore = {
            enable = true,
            url = 'https://www.schemastore.org/api/json/catalog.json',
          },
        },
      },
    })

    -- JSON
    vim.lsp.config('jsonls', {
      cmd = { 'vscode-json-language-server', '--stdio' },
      root_markers = { '.git' },
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        json = {
          validate = { enable = true },
        },
      },
    })

    -- TOML
    vim.lsp.config('taplo', {
      cmd = { 'taplo', 'lsp', 'stdio' },
      root_markers = { '.git' },
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
    vim.lsp.enable('gopls')
    vim.lsp.enable('dockerls')
    vim.lsp.enable('yamlls')
    vim.lsp.enable('jsonls')
    vim.lsp.enable('taplo')

    -- Format Python on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.py',
      callback = function()
        vim.lsp.buf.format({ name = 'ruff', timeout_ms = 1000 })
      end,
    })
  end,
  },

  -- Rust (rustaceanvim handles rust-analyzer with extra features)
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    dependencies = {
      'mfussenegger/nvim-dap',
      'hrsh7th/cmp-nvim-lsp',
    },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = on_attach,
          capabilities = get_capabilities(),
          default_settings = {
            ['rust-analyzer'] = {
              check = { command = 'clippy' },
              inlayHints = {
                chainingHints = { enable = true },
                typeHints = { enable = true },
                parameterHints = { enable = true },
              },
              cargo = { allFeatures = true },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },
}
