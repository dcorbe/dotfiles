-- ASCII art browser
vim.api.nvim_create_user_command("AsciiPreview", function()
  require("ascii").preview()
end, {})

vim.keymap.set("n", "<leader>A", function() require("ascii").preview() end, { desc = "Browse ASCII art" })
