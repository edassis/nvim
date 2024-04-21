vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = '[S]ave' })
-- Session create
vim.keymap.set('n', '<leader>ww>', '<cmd>mksession!<cr>', { desc = '[W]orkspace [w]rite session' })
-- Home screen
vim.keymap.set('n', '<leader>vs', require('mini.starter').open, { desc = 'Open mini starter' })
