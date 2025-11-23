return {
    "folke/drop.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("drop").setup({
            theme = "auto",  -- Auto-select based on date/holidays
            max = 40,
            interval = 150,
            screensaver = 1000 * 60 * 15,  -- 15 minutes
        })

        -- Trigger initial cursor movement to start timer
        vim.defer_fn(function()
            vim.cmd("doautocmd CursorMoved")
        end, 500)
    end,
}
