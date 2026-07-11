-- Snacks dashboard header: on each launch, randomly pick an animated
-- milli.nvim splash, a static ascii.nvim piece, or a truecolor ANSI art
-- from ansi-art/. Normal buffers don't interpret escape sequences, so the
-- ANSI case renders through a snacks `terminal` section instead of the
-- header. Set NVIM_DASH=milli|ascii|ansi to force a branch.
local milli = require("milli")
local ascii = require("ascii")

math.randomseed(os.time())

local ansi_files =
  vim.fn.globpath(vim.fn.stdpath("config") .. "/ansi-art", "*.ans", false, true)

-- `splash` stays nil unless the milli branch wins. When set, it names the milli
-- splash and must feed both the header seed (frame 0) and milli.snacks() below,
-- so milli's anchor-search can locate frame 0 in the dashboard buffer.
local splash
local header
local art_section

local choice = ({ milli = 1, ascii = 2, ansi = 3 })[vim.env.NVIM_DASH]
  or math.random(#ansi_files > 0 and 3 or 2)
if choice == 3 and #ansi_files == 0 then
  choice = 2
end

if choice == 1 then
  -- Animated milli splash. frames[1] is a list of lines; snacks wants a string.
  local splashes = milli.list()
  splash = splashes[math.random(#splashes)]
  header = table.concat(milli.load({ splash = splash }).frames[1], "\n")
elseif choice == 2 then
  -- Static random ascii.nvim art. get_random_global() returns a list of lines.
  header = table.concat(ascii.get_random_global(), "\n")
else
  -- Random ANSI art piece. Terminal sections need an explicit height (snacks
  -- can't measure command output); the trailing sleep keeps cat's output from
  -- racing the terminal setup.
  local art = ansi_files[math.random(#ansi_files)]
  art_section = {
    section = "terminal",
    cmd = "cat " .. vim.fn.shellescape(art) .. "; sleep .1",
    height = #vim.fn.readfile(art),
    padding = 1,
  }
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
      art_section or { section = "header" },
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
