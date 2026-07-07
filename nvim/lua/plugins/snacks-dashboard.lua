-- Snacks dashboard (replaces alpha-nvim)
local ascii = require("ascii")

-- Random ASCII art header, chosen once per launch (matches old alpha behavior).
-- get_random_global() returns a table of lines; snacks wants a single string.
local header = table.concat(ascii.get_random_global(), "\n")

-- Footer: count installed plugins in the vim.pack opt directory.
-- (The old alpha footer pointed at config/pack/plugins/start, which does not
-- exist under vim.pack, so it always reported 0.)
--
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
