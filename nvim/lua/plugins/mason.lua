return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry", -- roslyn + rzls
        },
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
      })

      -- Ensure non-LSP tools are installed (DAP adapters, etc.)
      local ensure_installed = {
        'java-debug-adapter',
        'java-test',
      }
      local mr = require('mason-registry')
      mr.refresh(function()
        for _, tool in ipairs(ensure_installed) do
          local pkg = mr.get_package(tool)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "vtsls",
          "tailwindcss",
          "eslint",
          "basedpyright",
          "ruff",
          "clangd",
          "gopls",
          "dockerls",
          "yamlls",
          "jsonls",
          "taplo",
          "html",
          "zls",
          "jdtls",
          "harper_ls",
        },
        automatic_installation = true,
      })
    end,
  },
}
