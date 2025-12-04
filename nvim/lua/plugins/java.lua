-- Java development with nvim-jdtls
-- Actual configuration is in ftplugin/java.lua (jdtls needs per-buffer setup)
return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    dependencies = {
      'mfussenegger/nvim-dap',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
}
