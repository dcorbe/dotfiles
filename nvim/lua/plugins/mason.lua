return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "rust_analyzer" }
            })
        end
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = "",
                },
            }
        })
    end
}

