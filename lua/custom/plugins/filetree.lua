
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', '/', "<cmd>Neotree toggle current reveal_force_cwd<cr>")
vim.keymap.set('n', '|', "<cmd>Neotree toggle reveal<cr>")
-- vim.keymap.set('n', 'gd', "<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>")
-- vim.keymap.set('n', '<leader>b', "<cmd>Neotree toggle show buffers right<cr>")
-- vim.keymap.set('n', '<leader>s', "<cmd>Neotree float git_status<cr>")

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {}
  end,
}
