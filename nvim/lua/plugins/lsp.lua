-- LSP Configuration

-- Shared LSP helpers
local function get_capabilities()
  return require('cmp_nvim_lsp').default_capabilities()
end

local function on_attach(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set('n', '<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { buffer = bufnr, desc = 'Toggle inlay hints' })
  end

  if client.name == 'harper_ls' then
    -- Native spell is off in these buffers, so z= is otherwise dead (E756).
    -- Point the muscle-memory key at harper's fixes: cursor on a flagged word,
    -- press z=, pick the replacement (or "add to dictionary").
    vim.keymap.set('n', 'z=', vim.lsp.buf.code_action,
      { buffer = bufnr, desc = 'Harper: spelling suggestions' })
  end
end

local capabilities = get_capabilities()

-- Lua (use system binary - Mason's has stale libbfd dependency)
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

-- YAML
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

-- HTML
vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  root_markers = { '.git' },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Zig
vim.lsp.config('zls', {
  cmd = { 'zls' },
  root_markers = { 'build.zig', 'zls.json', '.git' },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    zls = {
      enable_inlay_hints = true,
      inlay_hints_hide_redundant_param_names = true,
    },
  },
})

-- Grammar/spelling (harper-ls)
vim.lsp.config('harper_ls', {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = { 'markdown', 'text', 'gitcommit', 'mail' },  -- prose only, never code
  root_markers = { '.git' },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ['harper-ls'] = {
      linters = {
        -- Pure spell-check to start. Every grammar linter is off:
        -- they were the source of the noise. Add back individually if wanted.
        spell_check = true,
        spelled_numbers = false,
        an_a = false,
        sentence_capitalization = false,
        unclosed_quotes = false,
        wrong_quotes = false,
        long_sentences = false,
        repeated_words = false,
        spaces = false,            -- keep off: allows sentence-end double spaces
        matcher = false,
      },
    },
  },
})

-- Enable servers (Rust/C# handled by dedicated plugins)
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
vim.lsp.enable('html')
vim.lsp.enable('zls')
vim.lsp.enable('harper_ls')

-- Format Python on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.format({ name = 'ruff', timeout_ms = 1000 })
  end,
})

-- Disable built-in rust_analyzer (rustaceanvim manages it)
vim.lsp.enable('rust_analyzer', false)

-- Rustaceanvim (handles rust-analyzer with extra features)
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

-- C# (roslyn.nvim + rzls.nvim for Razor)
-- Configure rzls
require('rzls').setup({
  capabilities = get_capabilities(),
  on_attach = on_attach,
})

-- Configure roslyn LSP settings
vim.lsp.config('roslyn', {
  on_attach = on_attach,
  capabilities = get_capabilities(),
  settings = {
    ['csharp|inlay_hints'] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      dotnet_enable_inlay_hints_for_other_parameters = true,
      dotnet_enable_inlay_hints_for_parameters = true,
    },
    ['csharp|code_lens'] = {
      dotnet_enable_references_code_lens = true,
      dotnet_enable_tests_code_lens = true,
    },
  },
})

require('roslyn').setup({
  broad_search = true,
  config = {
    handlers = require('rzls.roslyn_handlers'),
  },
})
