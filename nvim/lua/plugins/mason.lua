return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "",
                        package_pending = "",
                        package_uninstalled = "",
                    },
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "rust_analyzer",
                    "lua_ls",
                    "vtsls",
                    "tailwindcss",
                    "eslint",
                    "basedpyright",
                    "ruff",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Configure rust_analyzer
            vim.lsp.config('rust_analyzer', {
                cmd = { 'rust-analyzer' },
                root_markers = { 'Cargo.toml' },
                capabilities = capabilities,
            })

            -- Configure lua_ls
            vim.lsp.config('lua_ls', {
                cmd = { 'lua-language-server' },
                root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            -- Configure vtsls (TypeScript/JavaScript/React)
            vim.lsp.config('vtsls', {
                cmd = { 'vtsls', '--stdio' },
                root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
                capabilities = capabilities,
                settings = {
                    vtsls = {
                        experimental = {
                            completion = {
                                enableServerSideFuzzyMatch = true,
                            },
                        },
                    },
                    typescript = {
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                            parameterTypes = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                    javascript = {
                        inlayHints = {
                            parameterNames = { enabled = "all" },
                            parameterTypes = { enabled = true },
                            variableTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            enumMemberValues = { enabled = true },
                        },
                    },
                },
            })

            -- Configure tailwindcss
            vim.lsp.config('tailwindcss', {
                cmd = { 'tailwindcss-language-server', '--stdio' },
                root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.cjs' },
                capabilities = capabilities,
                settings = {
                    tailwindCSS = {
                        classAttributes = { "class", "className", "classList", "ngClass" },
                        lint = {
                            cssConflict = "warning",
                            invalidApply = "error",
                            invalidConfigPath = "error",
                            invalidScreen = "error",
                            invalidTailwindDirective = "error",
                            invalidVariant = "error",
                            recommendedVariantOrder = "warning",
                        },
                        validate = true,
                    },
                },
            })

            -- Configure eslint
            vim.lsp.config('eslint', {
                cmd = { 'vscode-eslint-language-server', '--stdio' },
                root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'eslint.config.js' },
                capabilities = capabilities,
                settings = {
                    codeAction = {
                        disableRuleComment = {
                            enable = true,
                            location = "separateLine",
                        },
                        showDocumentation = {
                            enable = true,
                        },
                    },
                    codeActionOnSave = {
                        enable = false,
                        mode = "all",
                    },
                    format = true,
                    nodePath = "",
                    onIgnoredFiles = "off",
                    packageManager = "npm",
                    quiet = false,
                    rulesCustomizations = {},
                    run = "onType",
                    validate = "on",
                    workingDirectory = {
                        mode = "location",
                    },
                },
            })

            -- Configure basedpyright (Python LSP)
            vim.lsp.config('basedpyright', {
                cmd = { 'basedpyright-langserver', '--stdio' },
                root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json' },
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "standard",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                            autoImportCompletions = true,
                        },
                    },
                    python = {
                        analysis = {
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

            -- Configure ruff (Python linter/formatter)
            vim.lsp.config('ruff', {
                cmd = { 'ruff', 'server' },
                root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml' },
                capabilities = capabilities,
                settings = {
                    organizeImports = true,
                    fixAll = true,
                },
            })

            -- Enable LSP servers for matching filetypes
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('vtsls')
            vim.lsp.enable('tailwindcss')
            vim.lsp.enable('eslint')
            vim.lsp.enable('basedpyright')
            vim.lsp.enable('ruff')

            -- Format Python files on save with ruff
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.py",
                callback = function()
                    vim.lsp.buf.format({
                        name = "ruff",
                        timeout_ms = 1000,
                    })
                end,
            })
        end,
    },
}
