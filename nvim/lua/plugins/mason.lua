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
        },
        automatic_installation = true,
      })
    end,
  },
}
