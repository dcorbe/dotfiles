-- Yanky (yank history)
local yanky = require("yanky")

yanky.setup({
  ring = {
    history_length = 100,
    storage = "shada",
    sync_with_numbered_registers = true,
    cancel_event = "update",
    ignore_registers = { "_" },
  },
  picker = {
    select = {
      action = nil,
    },
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 300,
  },
  preserve_cursor_position = {
    enabled = true,
  },
})

local map = vim.keymap.set

map({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank" })
map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put after" })
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put before" })
map({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put after and leave cursor after" })
map({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put before and leave cursor after" })

map("n", "<c-p>", "<Plug>(YankyCycleForward)", { desc = "Cycle forward through yank history" })
map("n", "<c-n>", "<Plug>(YankyCycleBackward)", { desc = "Cycle backward through yank history" })

map("n", "<leader>p", function()
  require("fzf-lua").register_ui_select()
  yanky.yank_history.yank_history()
end, { desc = "Yank history" })
