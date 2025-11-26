return {
    "kndndrj/nvim-dbee",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
        require("dbee").install()
    end,
    cmd = { "Dbee" },
    keys = {
        { "<leader>DB", function() require("dbee").toggle() end, desc = "Toggle DB explorer" },
    },
    opts = {},
}
