-- Diagram.nvim (mermaid rendering)
-- Skip setup in headless mode (depends on image.nvim which needs a terminal)
if vim.fn.has('gui_running') == 0 and vim.api.nvim_list_uis()[1] == nil then
  return
end

require("diagram").setup({
  renderer_options = {
    mermaid = {
      background = "transparent",
      theme = "dark",
      scale = 6,
    },
  },
})
