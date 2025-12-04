return {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
        {
            "<leader>gX",
            "<cmd>silent Git rm --cached %<cr>",
            desc = "Untrack file (keep on disk)",
        },
        {
            "<leader>gB",
            "<cmd>Git blame<cr>",
            desc = "Blame file",
        },
        {
            "<leader>gl",
            "<cmd>Git log<cr>",
            desc = "Git log",
        },
    },
}
