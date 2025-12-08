-- Plugin initialization (native pack, no lazy.nvim)
-- Plugins are loaded from pack/plugins/start/ automatically
-- This file just runs their setup functions

-- Load colorscheme first
require("plugins.dracula")

-- Core utilities (no setup needed, just loaded)
-- plenary, nvim-web-devicons, nui.nvim are auto-loaded

-- Treesitter (load early, many plugins depend on it)
require("plugins.treesitter")
require("plugins.textobjects")

-- LSP & Completion
require("plugins.mason")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.copilot")

-- UI
require("plugins.lualine")
require("plugins.which-key")
require("plugins.alpha")
require("plugins.trouble")
require("plugins.todo-comments")
require("plugins.marks")
require("plugins.colorizer")
require("plugins.ufo")
require("plugins.render-markdown")
require("plugins.aerial")

-- Git
require("plugins.gitsigns")
require("plugins.fugitive")
require("plugins.diffview")
require("plugins.neogit")

-- Navigation & Search
require("plugins.fzf-lua")
require("plugins.harpoon")
require("plugins.flash")
require("plugins.oil")
require("plugins.spectre")

-- Text manipulation
require("plugins.comment")
require("plugins.surround")
require("plugins.easyalign")
require("plugins.autopairs")
require("plugins.dial")
require("plugins.treesj")
require("plugins.yanky")

-- Debug & Test
require("plugins.dap")
require("plugins.neotest")

-- Language-specific
require("plugins.crates")
require("plugins.java")

-- Focus & Zen
require("plugins.zen-mode")
require("plugins.twilight")
require("plugins.drop")

-- Images & Diagrams
require("plugins.image")
require("plugins.diagram")

-- Database
require("plugins.dbee")

-- Other/Fun
require("plugins.cellular-automaton")
require("plugins.ascii")
require("plugins.vscode-diff")
require("plugins.undotree")
