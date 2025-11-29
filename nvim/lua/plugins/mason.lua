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
        },
        -- NOTE: rust_analyzer NOT here - using rustup's version
        automatic_installation = true,
      })
    end,
  },
}
