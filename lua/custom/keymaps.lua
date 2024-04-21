-- "Re-sourcing your config is not supported with lazy.nvim"

-- Editor
vim.keymap.set('n', '<leader>a', 'ggVG', { desc = 'Select [a]ll' })
vim.keymap.set('n', '<leader>ew', '<cmd>w<cr>', { desc = '[E]ditor [w]rite file' })
vim.keymap.set('n', '<leader>er', '<cmd>source $MYVIMRC<cr>', { desc = '[E]ditor [r]eload config'})
vim.keymap.set('n', '<leader>es', '<cmd>source %<cr>', { desc = '[E]ditor [S]ource buffer'})


-- Workspace
-- Home screen
vim.keymap.set('n', '<leader>ww', require('mini.starter').open, { desc = '[W]orkspace home' })
-- Session create
vim.keymap.set('n', '<leader>ws', '<cmd>mksession!<cr>', { desc = '[W]orkspace [s]ave session' })
-- Update editor indentation
vim.keymap.set('n', '<leader>wi', '<cmd>GuessIndentation<cr>', { desc = '[W]orkspace Guess [I]ndentation' })

-- Telescope
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sa', function()
  builtin.find_files { cwd = vim.fn.expand '%:p:h' }
end, { desc = '[S]arch [A]djacent' })

-- Java
-- vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
-- vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
-- vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
-- vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
-- vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
-- vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })
