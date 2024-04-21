-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return { -- Start screen (https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-starter.md)
  { 'echasnovski/mini.starter', opts = {} },
  -- Sessions
  { 'echasnovski/mini.sessions', opts = {} },
  -- Better brackets mappings
  { 'echasnovski/mini.bracketed', opts = {} },
  -- Auto pair
  -- { 'echasnovski/mini.pairs', opts = {} },
  -- Scope line
  -- {
  --   'echasnovski/mini.indentscope',
  --   opts = {
  --     draw = {
  --       delay = 30,
  --       animation = require('mini.indentscope').gen_animation.none(),
  --     },
  --   },
  -- },
  -- Coment line and blocks ('gcc')
  { 'numToStr/Comment.nvim', opts = {} },
  -- Java LSP
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    config = function()
      -- local home = vim.env.HOME
      local java_path = vim.fn.system 'mise which java --tool=java@temurin-21'
      -- remove <NL> from string
      java_path = string.gsub(java_path, '\n', '')
      local java_root = vim.fs.normalize(vim.fs.dirname(java_path) .. '/..')

      -- Based on: https://github.com/exosyphon/nvim/blob/0aa48126c7f35f2009c5a695860a53c8a450485f/ftplugin/java.lua#
      local workspace_path = vim.fn.stdpath 'data' .. '/jdtls-workspace'
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local workspace_dir = vim.fs.joinpath(workspace_path, project_name)

      -- local status, jdtls = pcall(require, 'jdtls')
      -- if not status then
      --   return
      -- end
      -- local extendedClientCapabilities = jdtls.extendedClientCapabilities

      local config = {
        -- cmd = { home .. '/.local/share/jdtls/bin/jdtls' },
        -- cmd = { 'jdtls' },
        cmd = {
          java_path,
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED',
          '-javaagent:' .. vim.fn.stdpath 'data' .. '/mason/packages/jdtls/lombok.jar',
          '-jar',
          vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
          '-configuration',
          vim.fn.stdpath 'data' .. '/mason/packages/jdtls/config_linux',
          '-data',
          workspace_dir,
        },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = 'JavaSE-21',
                  -- path = '/usr/lib/jvm/java-21-openjdk-amd64/',
                  path = java_root,
                },
              },
            },
            signatureHelp = { enabled = true },
            -- extendedClientCapabilities = extendedClientCapabilities,
            maven = {
              downloadSources = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = 'all', -- literals, all, none
              },
            },
            format = {
              enabled = false,
            },
          },
        },
      }
      require('jdtls').start_or_attach(config)
    end,
  },
}
