-- Dial (increment/decrement)
local augend = require("dial.augend")
local config = require("dial.config")

config.augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.integer.alias.octal,
    augend.integer.alias.binary,
    augend.constant.alias.bool,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%m/%d/%Y"],
    augend.date.alias["%H:%M:%S"],
    augend.date.alias["%H:%M"],
    augend.constant.new({
      elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "and", "or" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "==", "!=" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "===", "!==" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "yes", "no" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "on", "off" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "true", "false" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "True", "False" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "enable", "disable" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "enabled", "disabled" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "<<<<<<< HEAD", "=======", ">>>>>>>" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "first", "second", "third", "fourth", "fifth" },
      word = true,
      cyclic = false,
    }),
    augend.constant.new({
      elements = { "start", "end" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "left", "right" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "up", "down" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "top", "bottom" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "before", "after" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "min", "max" },
      word = true,
      cyclic = true,
    }),
  },
  visual = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.integer.alias.octal,
    augend.integer.alias.binary,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%m/%d/%Y"],
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
})

local map = vim.keymap.set
local dial_map = require("dial.map")

map("n", "<C-a>", function() dial_map.manipulate("increment", "normal") end, { desc = "Increment" })
map("n", "<C-x>", function() dial_map.manipulate("decrement", "normal") end, { desc = "Decrement" })
map("v", "<C-a>", function() dial_map.manipulate("increment", "visual") end, { desc = "Increment (sequential)" })
map("v", "<C-x>", function() dial_map.manipulate("decrement", "visual") end, { desc = "Decrement (sequential)" })
map("v", "g<C-a>", function() dial_map.manipulate("increment", "gnormal") end, { desc = "Increment (same for all)" })
map("v", "g<C-x>", function() dial_map.manipulate("decrement", "gnormal") end, { desc = "Decrement (same for all)" })
