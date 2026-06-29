-- nvim-treesitter-textobjects (main branch, v1.0 API)
local to = require("nvim-treesitter-textobjects")
to.setup({
  select = { lookahead = true },
  move  = { set_jumps = true },
  swap  = {},
})

local sel   = require("nvim-treesitter-textobjects.select")
local move  = require("nvim-treesitter-textobjects.move")
local swap  = require("nvim-treesitter-textobjects.swap")
local map   = vim.keymap.set

-- select
map({ "x", "o" }, "af", function() sel.select_textobject("@function.outer", "textobjects") end, { desc = "outer function" })
map({ "x", "o" }, "if", function() sel.select_textobject("@function.inner", "textobjects") end, { desc = "inner function" })
map({ "x", "o" }, "ac", function() sel.select_textobject("@class.outer",    "textobjects") end, { desc = "outer class" })
map({ "x", "o" }, "ic", function() sel.select_textobject("@class.inner",    "textobjects") end, { desc = "inner class" })
map({ "x", "o" }, "aa", function() sel.select_textobject("@parameter.outer","textobjects") end, { desc = "outer parameter" })
map({ "x", "o" }, "ia", function() sel.select_textobject("@parameter.inner","textobjects") end, { desc = "inner parameter" })
map({ "x", "o" }, "al", function() sel.select_textobject("@loop.outer",     "textobjects") end, { desc = "outer loop" })
map({ "x", "o" }, "il", function() sel.select_textobject("@loop.inner",     "textobjects") end, { desc = "inner loop" })
map({ "x", "o" }, "ai", function() sel.select_textobject("@conditional.outer","textobjects") end, { desc = "outer conditional" })
map({ "x", "o" }, "ii", function() sel.select_textobject("@conditional.inner","textobjects") end, { desc = "inner conditional" })

-- move
map({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer",  "textobjects") end, { desc = "next function start" })
map({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.outer", "textobjects") end, { desc = "next parameter start" })
map({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer",    "textobjects") end, { desc = "next function end" })
map({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer",  "textobjects") end, { desc = "prev function start" })
map({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.outer", "textobjects") end, { desc = "prev parameter start" })
map({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer",    "textobjects") end, { desc = "prev function end" })

-- swap
map("n", "<leader>sn", function() swap.swap_next("@parameter.inner",     "textobjects") end, { desc = "swap next parameter" })
map("n", "<leader>sp", function() swap.swap_previous("@parameter.inner", "textobjects") end, { desc = "swap prev parameter" })

-- mini.ai
local ai = require("mini.ai")
ai.setup({
  n_lines = 500,
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer",    i = "@class.inner" }),
  },
})

-- various-textobjs
require("various-textobjs").setup({ keymaps = { useDefaults = false } })

local textobjs = require("various-textobjs")
map({ "o", "x" }, "aS", function() textobjs.subword("outer") end,        { desc = "outer subword" })
map({ "o", "x" }, "iS", function() textobjs.subword("inner") end,        { desc = "inner subword" })
map({ "o", "x" }, "U",  function() textobjs.url() end,                   { desc = "URL" })
map({ "o", "x" }, "an", function() textobjs.number("outer") end,         { desc = "outer number" })
map({ "o", "x" }, "in", function() textobjs.number("inner") end,         { desc = "inner number" })
map({ "o", "x" }, "av", function() textobjs.value("outer") end,          { desc = "outer value" })
map({ "o", "x" }, "iv", function() textobjs.value("inner") end,          { desc = "inner value" })
map({ "o", "x" }, "ak", function() textobjs.key("outer") end,            { desc = "outer key" })
map({ "o", "x" }, "ik", function() textobjs.key("inner") end,            { desc = "inner key" })
map({ "o", "x" }, "aI", function() textobjs.indentation("outer","outer") end, { desc = "outer indentation" })
map({ "o", "x" }, "iI", function() textobjs.indentation("inner","inner") end, { desc = "inner indentation" })
