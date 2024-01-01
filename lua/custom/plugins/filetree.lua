-- vim.keymap.set('n', '/', "<cmd>Neotree toggle current reveal_force_cwd<cr>")
vim.keymap.set('n', '|', "<cmd>Neotree toggle<cr>")
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
  config = function()
    require('neo-tree').setup {

      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
      -- filesystem = {
      --   window = {
      --     mappings = {
      --       ["o"] = "system_open",
      --     },
      --   },
      --   commands = {
      --     system_open = function(state)
      --       local node = state.tree:get_node()
      --       local path = node:get_id()
      --       -- macOs: open file in default application in the background.
      --       vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
      --       -- Linux: open file in default application
      --       vim.fn.jobstart({ "xdg-open", path }, { detach = true })
      --       -- Windows
      --       vim.fn.jobstart({ "xdg-open", path }, { detach = true })
      --     end,
      --   },
      -- },
    }
  end,
}
