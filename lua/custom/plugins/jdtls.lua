-- Java LSP
vim.pack.add { 'https://github.com/mfussenegger/nvim-jdtls' }

-- local java_path = nil
-- if vim.uv.os_uname().sysname == 'Windows_NT' then
--   -- https://neo.vimhelp.org/lua.txt.html#lua-vim-system
--   local ps = vim.system({ 'powershell', '-c', '(Get-Command java).Source' }, { text = true }):wait()
--   java_path = ps.stdout
-- else
--   local ps = vim.system({ 'bash', '-c', 'which java' }, { text = true }):wait()
--   java_path = ps.stdout
-- end
-- if #java_path == 0 then
--   print "Error! Not able to find 'java' in PATH"
--   return
-- end

-- local java_root = vim.fs.normalize(vim.fs.dirname(java_path) .. '/..')

-- Based on: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/jdtls.lua
local function get_jdtls_cache_dir()
  return vim.fn.stdpath('cache') .. '/jdtls'
end

local function get_jdtls_workspace_dir()
  return get_jdtls_cache_dir() .. '/workspace'
end

local function get_jdtls_jvm_args()
  local env = os.getenv('JDTLS_JVM_ARGS')
  local args = {}
  for a in string.gmatch((env or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end

  -- Based on: https://github.com/exosyphon/nvim/blob/0aa48126c7f35f2009c5a695860a53c8a450485f/ftplugin/java.lua#
  local lombok_args = {
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
    '-javaagent:' .. vim.fs.joinpath(vim.fn.stdpath 'data', '/mason/packages/jdtls/lombok.jar'),
    '-jar',
    vim.fs.joinpath(vim.fn.stdpath 'data', vim.fn.glob '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    vim.fs.joinpath(vim.fn.stdpath 'data', '/mason/packages/jdtls/config_linux'),
  }
  for i,v in ipairs(lombok_args) do
    local arg = string.format('--jvm-arg=%s', v)
    table.insert(args, arg)
  end

  -- print("Args: ")
  -- for i,v in ipairs(args) do
  --   print('  '..v)
  -- end

  return unpack(args)
end

local root_markers1 = {
  -- Multi-module projects
  'mvnw', -- Maven
  'gradlew', -- Gradle
  'settings.gradle', -- Gradle
  'settings.gradle.kts', -- Gradle
  -- Use git directory as last resort for multi-module maven projects
  -- In multi-module maven projects it is not really possible to determine what is the parent directory
  -- and what is submodule directory. And jdtls does not break if the parent directory is at higher level than
  -- actual parent pom.xml so propagating all the way to root git directory is fine
  '.git',
}
local root_markers2 = {
  -- Single-module projects
  'build.xml', -- Ant
  'pom.xml', -- Maven
  'build.gradle', -- Gradle
  'build.gradle.kts', -- Gradle
}

---@type vim.lsp.Config
local config = {
  ---@param dispatchers? vim.lsp.rpc.Dispatchers
  ---@param config vim.lsp.ClientConfig
  cmd = function(dispatchers, config)
    local workspace_dir = get_jdtls_workspace_dir()
    local data_dir = workspace_dir

    if config.root_dir then
      data_dir = data_dir .. '/' .. vim.fn.fnamemodify(config.root_dir, ':p:h:t')
    end

    local config_cmd = {
      'jdtls',
      '-data',
      data_dir,
      get_jdtls_jvm_args(),
    }

    return vim.lsp.rpc.start(config_cmd, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end,
  settings = {
    java = {
      -- configuration = {
      --   runtimes = {
      --     {
      --       name = 'JavaSE-21',
      --       -- path = java_root,
      --       path = 'java'
      --     },
      --   },
      -- },
      signatureHelp = { enabled = true },
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
  filetypes = { 'java' },
  root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers1, root_markers2 }
    or vim.list_extend(root_markers1, root_markers2),
  init_options = {},
}

vim.lsp.config('jdtls', config)
vim.lsp.enable('jdtls')