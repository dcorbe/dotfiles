-- Snacks dashboard with milli.nvim animated ASCII splash header.
local milli = require("milli")

-- Pick a random animated splash once per launch (keeps the old random-art
-- behavior, now animated). The SAME splash name must feed both the header seed
-- and milli.snacks() below, so milli's anchor-search can locate frame 0 in the
-- dashboard buffer and animate over it.
math.randomseed(os.time())
local splashes = milli.list()
local splash = splashes[math.random(#splashes)]

-- Seed the header with frame 0 of the chosen splash. frames[1] is a list of
-- lines; snacks wants a single string.
local header = table.concat(milli.load({ splash = splash }).frames[1], "\n")

-- Footer: count installed plugins in the vim.pack opt directory.
-- A whole section may be a function (snacks resolves it by calling it), but the
-- `text` field within must be a string or Text[], never a function.
local function footer_section()
  local opt_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt"
  local plugins = vim.fn.globpath(opt_dir, "*", false, true)
  return {
    text = { { "Loaded " .. #plugins .. " plugins", hl = "SnacksDashboardFooter" } },
    align = "center",
    padding = 1,
  }
end

require("snacks").setup({
  dashboard = {
    enabled = true,
    preset = {
      header = header,
      keys = {
        { key = "f", desc = "Find file", action = ":FzfLua files" },
        { key = "r", desc = "Recent files", action = ":FzfLua oldfiles" },
        { key = "g", desc = "Grep text", action = ":FzfLua live_grep" },
        { key = "-", desc = "File explorer", action = ":Oil" },
        { key = "q", desc = "Quit", action = ":qa" },
      },
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      footer_section,
    },
  },
})

-- Start the animation. Hooks SnacksDashboardOpened; splash must match the seed.
-- loop=true replays continuously (without it, runtime.play stops after one pass).
milli.snacks({ splash = splash, loop = true })
