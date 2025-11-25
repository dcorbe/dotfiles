return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")

        fzf.setup({
            -- Borderless design to match your old telescope config
            winopts = {
                border = "none",
                preview = {
                    border = "none",
                    wrap = "nowrap",
                    horizontal = "right:60%",
                },
                width = 0.9,
                height = 0.8,
            },
            -- Clean UI
            fzf_opts = {
                ["--layout"] = "reverse",
                ["--info"] = "inline",
            },
            files = {
                fd_opts = "--type f --hidden --exclude .git --exclude node_modules",
            },
            grep = {
                rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git' -g '!node_modules'",
            },
        })

        -- Keymaps (same as your telescope bindings)
        local map = vim.keymap.set
        map("n", "<leader>ff", fzf.files, { desc = "Find files" })
        map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
        map("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
        map("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
        map("n", "<leader>fk", fzf.keymaps, { desc = "Keymaps" })
    end,
}
