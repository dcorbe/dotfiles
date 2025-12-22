-- Oil file manager
require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["gs"] = {
      callback = function()
        vim.ui.input({ prompt = "SSH host: " }, function(host)
          if host then
            vim.cmd("edit oil-ssh://" .. host .. "/")
          end
        end)
      end,
      desc = "Open SSH connection",
    },
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
