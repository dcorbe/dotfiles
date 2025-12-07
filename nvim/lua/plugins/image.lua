-- Image.nvim
-- Skip setup in headless mode (no terminal)
if vim.fn.has('gui_running') == 0 and vim.api.nvim_list_uis()[1] == nil then
  return
end

require("image").setup({
  backend = "kitty",
  processor = "magick_rock",
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      only_render_image_at_cursor = false,
    },
    neorg = { enabled = false },
    typst = { enabled = false },
    html = { enabled = false },
    css = { enabled = false },
  },
  max_width = nil,
  max_height = nil,
  max_height_window_percentage = 50,
  max_width_window_percentage = nil,
  window_overlap_clear_enabled = true,
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
})
