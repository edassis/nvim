-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Start screen (https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md)
  { 'echasnovski/mini.starter', opts = {} },
  -- Sessions
  { 'echasnovski/mini.sessions', opts = {} },
  -- Better brackets mappings
  { 'echasnovski/mini.bracketed', opts = {} },
  -- Auto pair
  { 'echasnovski/mini.pairs', opts = {} },
  -- Scope line
  {
    'echasnovski/mini.indentscope',
    opts = {
      draw = {
        delay = 30,
        animation = require('mini.indentscope').gen_animation.none(),
      },
    },
  },
  -- Coment line and blocks ('gcc')
  { 'numToStr/Comment.nvim', opts = {} },
  -- Java LSP
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    config = function()
      local home = vim.env.HOME
      local config = {
        cmd = { home .. '/.local/share/jdtls/bin/jdtls' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = 'JavaSE-21',
                  path = '/usr/lib/jvm/java-21-openjdk-amd64/',
                },
              },
            },
          },
        },
      }
      require('jdtls').start_or_attach(config)
    end,
  },
}
