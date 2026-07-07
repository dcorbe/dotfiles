-- Snacks dashboard header: on each launch, randomly pick EITHER an animated
-- milli.nvim splash OR a static ascii.nvim piece.
local milli = require("milli")
local ascii = require("ascii")

math.randomseed(os.time())

-- `splash` stays nil for the static ascii case. When set, it names the milli
-- splash and must feed both the header seed (frame 0) and milli.snacks() below,
-- so milli's anchor-search can locate frame 0 in the dashboard buffer.
local splash
local header
if math.random(2) == 1 then
  -- Animated milli splash. frames[1] is a list of lines; snacks wants a string.
  local splashes = milli.list()
  splash = splashes[math.random(#splashes)]
  header = table.concat(milli.load({ splash = splash }).frames[1], "\n")
else
  -- Static random ascii.nvim art. get_random_global() returns a list of lines.
  header = table.concat(ascii.get_random_global(), "\n")
end

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

-- Start the animation only when a milli splash was chosen. Hooks
-- SnacksDashboardOpened; splash matches the seeded header. loop=true replays
-- continuously (without it, runtime.play stops after one pass).
if splash then
  milli.snacks({ splash = splash, loop = true })
end
