return {
    "folke/zen-mode.nvim",
    dependencies = {
        "folke/twilight.nvim",
    },
    cmd = "ZenMode",
    keys = {
        {
            "<leader>z",
            "<cmd>ZenMode<cr>",
            desc = "Toggle Zen Mode",
        },
    },
    opts = {
        window = {
            backdrop = 0.95, -- shade the backdrop of the Zen window
            width = 0.4, -- width of the Zen window
            height = 1, -- height of the Zen window (1 = 100%)
            options = {
                signcolumn = "no", -- disable signcolumn
                number = false, -- disable number column
                relativenumber = false, -- disable relative numbers
                cursorline = false, -- disable cursorline
                cursorcolumn = false, -- disable cursor column
                foldcolumn = "0", -- disable fold column
                list = false, -- disable whitespace characters
            },
        },
        plugins = {
            -- disable some global vim options (vim.o...)
            options = {
                enabled = true,
                ruler = false, -- disables the ruler text in the cmd line area
                showcmd = false, -- disables the command in the last line of the screen
                laststatus = 0, -- turn off the statusline in zen mode
            },
            twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
            gitsigns = { enabled = false }, -- disables git signs
            tmux = { enabled = true }, -- hide tmux status bar in zen mode
            -- this will change the font size on kitty when in zen mode
            -- to make this work, you need to set the following kitty options:
            -- - allow_remote_control socket-only
            -- - listen_on unix:/tmp/kitty
            kitty = {
                enabled = false,
                font = "+4", -- font size increment
            },
            -- this will change the font size on alacritty when in zen mode
            alacritty = {
                enabled = false,
                font = "14", -- font size
            },
            -- this will change the font size on wezterm when in zen mode
            wezterm = {
                enabled = false,
                font = "+4", -- font size increment
            },
        },
        on_open = function(win)
            -- Optional: do something when zen mode opens
        end,
        on_close = function()
            -- Optional: do something when zen mode closes
        end,
    },
}
