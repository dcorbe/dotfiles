return {
    "MaximilianLloyd/ascii.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
        { "<leader>A", function() require("ascii").preview() end, desc = "Browse ASCII art" },
    },
    cmd = { "AsciiPreview" },
    config = function()
        vim.api.nvim_create_user_command("AsciiPreview", function()
            require("ascii").preview()
        end, {})
    end,
}
