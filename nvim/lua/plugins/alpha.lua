return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "MaximilianLloyd/ascii.nvim",
        "folke/which-key.nvim",
    },
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local ascii = require("ascii")

        -- Random ASCII art header
        dashboard.section.header.val = ascii.get_random_global()

        -- Essential buttons
        dashboard.section.buttons.val = {
            dashboard.button("f", "  Find file", ":FzfLua files<CR>"),
            dashboard.button("r", "  Recent files", ":FzfLua oldfiles<CR>"),
            dashboard.button("g", "  Grep text", ":FzfLua live_grep<CR>"),
            dashboard.button("-", "  File explorer", ":Oil<CR>"),
            dashboard.button("p", "  Plugins", ":Lazy<CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
        }

        -- Footer
        dashboard.section.footer.val = function()
            local stats = require("lazy").stats()
            return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded"
        end

        -- Layout
        dashboard.config.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        -- Styling
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.section.footer.opts.hl = "AlphaFooter"

        alpha.setup(dashboard.config)

        -- Disable folding on alpha buffer
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "alpha",
            callback = function()
                vim.opt_local.foldenable = false
                vim.opt_local.cursorline = false
            end,
        })
    end,
}
