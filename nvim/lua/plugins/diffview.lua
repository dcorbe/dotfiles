return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
        {
            "<leader>gd",
            "<cmd>DiffviewOpen<cr>",
            desc = "Open Diffview",
        },
        {
            "<leader>gh",
            "<cmd>DiffviewFileHistory %<cr>",
            desc = "File History (current file)",
        },
        {
            "<leader>gH",
            "<cmd>DiffviewFileHistory<cr>",
            desc = "File History (all)",
        },
        {
            "<leader>gm",
            "<cmd>DiffviewOpen<cr>",
            desc = "Merge Tool",
        },
        {
            "<leader>gq",
            "<cmd>DiffviewClose<cr>",
            desc = "Close Diffview",
        },
    },
    config = function()
        local actions = require("diffview.actions")

        require("diffview").setup({
            diff_binaries = false,
            enhanced_diff_hl = false,
            use_icons = true,
            icons = {
                folder_closed = "",
                folder_open = "",
            },
            signs = {
                fold_closed = "",
                fold_open = "",
                done = "✓",
            },
            view = {
                default = {
                    layout = "diff2_horizontal",
                    winbar_info = false,
                },
                merge_tool = {
                    layout = "diff3_horizontal",
                    disable_diagnostics = true,
                    winbar_info = true,
                },
                file_history = {
                    layout = "diff2_horizontal",
                    winbar_info = false,
                },
            },
            file_panel = {
                listing_style = "tree",
                tree_options = {
                    flatten_dirs = true,
                    folder_statuses = "only_folded",
                },
                win_config = {
                    position = "left",
                    width = 35,
                    win_opts = {},
                },
            },
            file_history_panel = {
                log_options = {
                    git = {
                        single_file = {
                            diff_merges = "combined",
                        },
                        multi_file = {
                            diff_merges = "first-parent",
                        },
                    },
                },
                win_config = {
                    position = "bottom",
                    height = 16,
                    win_opts = {},
                },
            },
            commit_log_panel = {
                win_config = {
                    win_opts = {},
                },
            },
            default_args = {
                DiffviewOpen = {},
                DiffviewFileHistory = {},
            },
            hooks = {},
            keymaps = {
                disable_defaults = false,
                view = {
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
                    ["<leader>e"] = actions.focus_files,
                    ["<leader>b"] = actions.toggle_files,
                },
                file_panel = {
                    ["j"] = actions.next_entry,
                    ["<down>"] = actions.next_entry,
                    ["k"] = actions.prev_entry,
                    ["<up>"] = actions.prev_entry,
                    ["<cr>"] = actions.select_entry,
                    ["o"] = actions.select_entry,
                    ["<2-LeftMouse>"] = actions.select_entry,
                    ["-"] = actions.toggle_stage_entry,
                    ["S"] = actions.stage_all,
                    ["U"] = actions.unstage_all,
                    ["X"] = actions.restore_entry,
                    ["R"] = actions.refresh_files,
                    ["L"] = actions.open_commit_log,
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
                    ["i"] = actions.listing_style,
                    ["f"] = actions.toggle_flatten_dirs,
                    ["<leader>e"] = actions.focus_files,
                    ["<leader>b"] = actions.toggle_files,
                },
                file_history_panel = {
                    ["g!"] = actions.options,
                    ["<C-A-d>"] = actions.open_in_diffview,
                    ["y"] = actions.copy_hash,
                    ["L"] = actions.open_commit_log,
                    ["zR"] = actions.open_all_folds,
                    ["zM"] = actions.close_all_folds,
                    ["j"] = actions.next_entry,
                    ["<down>"] = actions.next_entry,
                    ["k"] = actions.prev_entry,
                    ["<up>"] = actions.prev_entry,
                    ["<cr>"] = actions.select_entry,
                    ["o"] = actions.select_entry,
                    ["<2-LeftMouse>"] = actions.select_entry,
                    ["<tab>"] = actions.select_next_entry,
                    ["<s-tab>"] = actions.select_prev_entry,
                    ["gf"] = actions.goto_file,
                    ["<C-w><C-f>"] = actions.goto_file_split,
                    ["<C-w>gf"] = actions.goto_file_tab,
                    ["<leader>e"] = actions.focus_files,
                    ["<leader>b"] = actions.toggle_files,
                },
                option_panel = {
                    ["<tab>"] = actions.select_entry,
                    ["q"] = actions.close,
                },
            },
        })
    end,
}
