return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antaris/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "rouge8/neotest-rust",
        "nvim-neotest/neotest-jest",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    args = { "--log-level", "DEBUG" },
                    runner = "pytest",
                }),
                require("neotest-rust") {
                    args = { "--no-capture" },
                },
                require("neotest-jest")({
                    jestCommand = "npm test --",
                    jestConfigFile = "custom.jest.config.ts",
                    env = { CI = true },
                    cwd = function()
                        return vim.fn.getcwd()
                    end,
                }),
            },
            discovery = {
                enabled = true,
            },
            diagnostic = {
                enabled = true,
                severity = vim.diagnostic.severity.ERROR,
            },
            floating = {
                border = "rounded",
                max_height = 0.6,
                max_width = 0.6,
            },
            icons = {
                running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                passed = "",
                running = "",
                failed = "",
                skipped = "",
                unknown = "",
            },
            output = {
                enabled = true,
                open_on_run = false,
            },
            quickfix = {
                enabled = true,
                open = false,
            },
            status = {
                enabled = true,
                virtual_text = false,
                signs = true,
            },
            summary = {
                enabled = true,
                animated = true,
                follow = true,
                expand_errors = true,
                mappings = {
                    attach = "a",
                    clear_marked = "M",
                    clear_target = "T",
                    debug = "d",
                    debug_marked = "D",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    expand_all = "e",
                    jumpto = "i",
                    mark = "m",
                    next_failed = "J",
                    output = "o",
                    prev_failed = "K",
                    run = "r",
                    run_marked = "R",
                    short = "O",
                    stop = "u",
                    target = "t",
                    watch = "w",
                },
            },
        })
    end,
    keys = {
        {
            "<leader>tt",
            function()
                require("neotest").run.run()
            end,
            desc = "Run nearest test",
        },
        {
            "<leader>tf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            desc = "Run tests in file",
        },
        {
            "<leader>tT",
            function()
                require("neotest").run.run(vim.fn.getcwd())
            end,
            desc = "Run all tests",
        },
        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle test summary",
        },
        {
            "<leader>to",
            function()
                require("neotest").output.open({ enter = true, auto_close = true })
            end,
            desc = "Show test output",
        },
        {
            "<leader>tO",
            function()
                require("neotest").output_panel.toggle()
            end,
            desc = "Toggle test output panel",
        },
        {
            "<leader>tS",
            function()
                require("neotest").run.stop()
            end,
            desc = "Stop tests",
        },
        {
            "<leader>td",
            function()
                require("neotest").run.run({ strategy = "dap" })
            end,
            desc = "Debug nearest test",
        },
        {
            "<leader>tw",
            function()
                require("neotest").watch.toggle()
            end,
            desc = "Toggle watch mode",
        },
        {
            "[t",
            function()
                require("neotest").jump.prev({ status = "failed" })
            end,
            desc = "Jump to previous failed test",
        },
        {
            "]t",
            function()
                require("neotest").jump.next({ status = "failed" })
            end,
            desc = "Jump to next failed test",
        },
    },
}
