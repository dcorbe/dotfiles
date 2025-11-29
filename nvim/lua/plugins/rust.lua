return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  init = function()
    -- Configure BEFORE plugin loads
    vim.g.rustaceanvim = {
      tools = {
        -- rustaceanvim tools config
      },
      server = {
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>ih', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, { buffer = bufnr, desc = 'Toggle inlay hints' })
        end,
        default_settings = {
          ['rust-analyzer'] = {
            check = {
              command = 'clippy',
            },
            inlayHints = {
              chainingHints = { enable = true },
              typeHints = { enable = true },
              parameterHints = { enable = true },
            },
            cargo = {
              allFeatures = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
      dap = {
        -- DAP config inherited from dap.lua
      },
    }
  end,
}
