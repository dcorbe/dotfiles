-- Undotree configuration
-- Visualizes vim's undo tree structure

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle undotree' })

-- Focus undotree window when opened
vim.g.undotree_SetFocusWhenToggle = 1

-- Window layout: tree on left, diff below
vim.g.undotree_WindowLayout = 2

-- Shorter timestamps
vim.g.undotree_ShortIndicators = 1

-- Hide "Press ? for help"
vim.g.undotree_HelpLine = 0
