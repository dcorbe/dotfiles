-- Neotest
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
      cwd = function() return vim.fn.getcwd() end,
    }),
  },
  discovery = { enabled = true },
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

-- Keymaps
local map = vim.keymap.set
local neotest = require("neotest")

map("n", "<leader>tt", function() neotest.run.run() end, { desc = "Run nearest test" })
map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run tests in file" })
map("n", "<leader>tT", function() neotest.run.run(vim.fn.getcwd()) end, { desc = "Run all tests" })
map("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
map("n", "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = "Show test output" })
map("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle test output panel" })
map("n", "<leader>tS", function() neotest.run.stop() end, { desc = "Stop tests" })
map("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
map("n", "<leader>tw", function() neotest.watch.toggle() end, { desc = "Toggle watch mode" })
