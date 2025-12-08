#!/bin/bash
# Plugin installation script - clones plugins into pack/plugins/start
set -e

cd "$(dirname "$0")"

PACK_DIR="pack/plugins/start"
mkdir -p "$PACK_DIR"

add_plugin() {
    local repo=$1
    local name=${2:-$(basename "$repo" .git)}
    local branch=${3:-}

    if [ -d "$PACK_DIR/$name" ]; then
        echo "Skipping $name (already exists)"
        return
    fi

    echo "Cloning $name..."
    if [ -n "$branch" ]; then
        git clone --depth 1 -b "$branch" "https://github.com/$repo.git" "$PACK_DIR/$name"
    else
        git clone --depth 1 "https://github.com/$repo.git" "$PACK_DIR/$name"
    fi
}

# Core dependencies (load first)
add_plugin "nvim-lua/plenary.nvim" "plenary.nvim"
add_plugin "nvim-tree/nvim-web-devicons" "nvim-web-devicons"
add_plugin "MunifTanjim/nui.nvim" "nui.nvim"
add_plugin "kevinhwang91/promise-async" "promise-async"
add_plugin "nvim-neotest/nvim-nio" "nvim-nio"

# Treesitter
add_plugin "nvim-treesitter/nvim-treesitter" "nvim-treesitter"
add_plugin "nvim-treesitter/nvim-treesitter-textobjects" "nvim-treesitter-textobjects"

# LSP & Mason
add_plugin "neovim/nvim-lspconfig" "nvim-lspconfig"
add_plugin "williamboman/mason.nvim" "mason.nvim"
add_plugin "williamboman/mason-lspconfig.nvim" "mason-lspconfig.nvim"

# Completion
add_plugin "hrsh7th/nvim-cmp" "nvim-cmp"
add_plugin "hrsh7th/cmp-nvim-lsp" "cmp-nvim-lsp"
add_plugin "hrsh7th/cmp-nvim-lsp-signature-help" "cmp-nvim-lsp-signature-help"
add_plugin "hrsh7th/cmp-buffer" "cmp-buffer"
add_plugin "hrsh7th/cmp-path" "cmp-path"
add_plugin "L3MON4D3/LuaSnip" "LuaSnip"
add_plugin "saadparwaiz1/cmp_luasnip" "cmp_luasnip"

# Copilot
add_plugin "zbirenbaum/copilot.lua" "copilot.lua"
add_plugin "zbirenbaum/copilot-cmp" "copilot-cmp"

# Language-specific
add_plugin "mrcjkb/rustaceanvim" "rustaceanvim"
add_plugin "saecki/crates.nvim" "crates.nvim"
add_plugin "seblyng/roslyn.nvim" "roslyn.nvim"
add_plugin "tris203/rzls.nvim" "rzls.nvim"
add_plugin "mfussenegger/nvim-jdtls" "nvim-jdtls"

# Debug & Test
add_plugin "mfussenegger/nvim-dap" "nvim-dap"
add_plugin "rcarriga/nvim-dap-ui" "nvim-dap-ui"
add_plugin "theHamsta/nvim-dap-virtual-text" "nvim-dap-virtual-text"
add_plugin "jay-babu/mason-nvim-dap.nvim" "mason-nvim-dap.nvim"
add_plugin "nvim-neotest/neotest" "neotest"
add_plugin "nvim-neotest/neotest-python" "neotest-python"
add_plugin "rouge8/neotest-rust" "neotest-rust"
add_plugin "nvim-neotest/neotest-jest" "neotest-jest"

# Git
add_plugin "tpope/vim-fugitive" "vim-fugitive"
add_plugin "lewis6991/gitsigns.nvim" "gitsigns.nvim"
add_plugin "sindrets/diffview.nvim" "diffview.nvim"
add_plugin "NeogitOrg/neogit" "neogit"

# Navigation & Search
add_plugin "ibhagwan/fzf-lua" "fzf-lua"
add_plugin "ThePrimeagen/harpoon" "harpoon" "harpoon2"
add_plugin "folke/flash.nvim" "flash.nvim"
add_plugin "stevearc/oil.nvim" "oil.nvim"
add_plugin "stevearc/aerial.nvim" "aerial.nvim"
add_plugin "nvim-pack/nvim-spectre" "nvim-spectre"

# Text manipulation
add_plugin "numToStr/Comment.nvim" "Comment.nvim"
add_plugin "tpope/vim-surround" "vim-surround"
add_plugin "junegunn/vim-easy-align" "vim-easy-align"
add_plugin "windwp/nvim-autopairs" "nvim-autopairs"
add_plugin "echasnovski/mini.ai" "mini.ai"
add_plugin "chrisgrieser/nvim-various-textobjs" "nvim-various-textobjs"
add_plugin "monaqa/dial.nvim" "dial.nvim"
add_plugin "Wansmer/treesj" "treesj"
add_plugin "gbprod/yanky.nvim" "yanky.nvim"

# UI
add_plugin "dracula/vim" "dracula"
add_plugin "nvim-lualine/lualine.nvim" "lualine.nvim"
add_plugin "goolord/alpha-nvim" "alpha-nvim"
add_plugin "MaximilianLloyd/ascii.nvim" "ascii.nvim"
add_plugin "folke/which-key.nvim" "which-key.nvim"
add_plugin "folke/trouble.nvim" "trouble.nvim"
add_plugin "folke/todo-comments.nvim" "todo-comments.nvim"
add_plugin "chentoast/marks.nvim" "marks.nvim"
add_plugin "NvChad/nvim-colorizer.lua" "nvim-colorizer.lua"
add_plugin "kevinhwang91/nvim-ufo" "nvim-ufo"
add_plugin "MeanderingProgrammer/render-markdown.nvim" "render-markdown.nvim"

# Focus & Zen
add_plugin "folke/zen-mode.nvim" "zen-mode.nvim"
add_plugin "folke/twilight.nvim" "twilight.nvim"
add_plugin "folke/drop.nvim" "drop.nvim"

# Fun
add_plugin "Eandrju/cellular-automaton.nvim" "cellular-automaton.nvim"

# Database
add_plugin "kndndrj/nvim-dbee" "nvim-dbee"

# Images & Diagrams
add_plugin "3rd/image.nvim" "image.nvim"
add_plugin "3rd/diagram.nvim" "diagram.nvim"

# Other
add_plugin "esmuellert/vscode-diff.nvim" "vscode-diff.nvim"
add_plugin "mbbill/undotree" "undotree"

echo ""
echo "Done! Run :helptags ALL in nvim to generate help tags."
