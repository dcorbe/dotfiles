-- Plugin installation via vim.pack (native package manager)
-- This only handles installation/updates. Config is in lua/plugins/*.lua

vim.pack.add({
  -- Core dependencies
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/kevinhwang91/promise-async',

  -- Colorscheme
  'https://github.com/dracula/vim',

  -- Treesitter
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',

  -- LSP & Mason
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',

  -- Completion
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',

  -- Copilot
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/zbirenbaum/copilot-cmp',

  -- UI
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/goolord/alpha-nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/chentoast/marks.nvim',
  'https://github.com/NvChad/nvim-colorizer.lua',
  'https://github.com/kevinhwang91/nvim-ufo',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/stevearc/aerial.nvim',

  -- Git
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/NeogitOrg/neogit',

  -- Navigation & Search
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/ThePrimeagen/harpoon',
  'https://github.com/folke/flash.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-pack/nvim-spectre',

  -- Text manipulation
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/tpope/vim-surround',
  'https://github.com/junegunn/vim-easy-align',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/monaqa/dial.nvim',
  'https://github.com/Wansmer/treesj',
  'https://github.com/gbprod/yanky.nvim',
  'https://github.com/echasnovski/mini.ai',
  'https://github.com/chrisgrieser/nvim-various-textobjs',

  -- Debug
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',

  -- Test
  'https://github.com/nvim-neotest/neotest',
  'https://github.com/nvim-neotest/neotest-jest',
  'https://github.com/nvim-neotest/neotest-python',
  'https://github.com/rouge8/neotest-rust',

  -- Language-specific
  'https://github.com/saecki/crates.nvim',
  'https://github.com/mfussenegger/nvim-jdtls',
  'https://github.com/mrcjkb/rustaceanvim',
  'https://github.com/seblyng/roslyn.nvim',
  'https://github.com/tris203/rzls.nvim',

  -- Focus & Zen
  'https://github.com/folke/zen-mode.nvim',
  'https://github.com/folke/twilight.nvim',
  'https://github.com/folke/drop.nvim',

  -- Images & Diagrams
  'https://github.com/3rd/image.nvim',
  'https://github.com/3rd/diagram.nvim',

  -- Database
  'https://github.com/kndndrj/nvim-dbee',

  -- Other
  'https://github.com/Eandrju/cellular-automaton.nvim',
  'https://github.com/MaximilianLloyd/ascii.nvim',
  'https://github.com/esmuellert/vscode-diff.nvim',
  'https://github.com/mbbill/undotree',
})
