vim.g.have_nerd_font = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.relativenumber = true

vim.o.undofile = true

-- Python provider
-- https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments
-- NOTE: On windows with mise, used `uv venv --seed --managed-python .venv`
if vim.uv.os_uname().sysname == 'Windows_NT' then
  vim.g.python3_host_prog = vim.fs.joinpath(vim.fn.stdpath 'data', '/.venv/Scripts/python.exe')
else
  vim.g.python3_host_prog = vim.fs.joinpath(vim.fn.stdpath 'data', '/.venv/bin/python3')
end
vim.g.python_host_prog = vim.g.python3_host_prog

-- https://www.reddit.com/r/neovim/comments/tci7qf/comment/i0gru59/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- local uname = vim.loop.os_uname()
-- _G.OS = uname.sysname
-- _G.IS_MAC = OS == 'Darwin'
-- _G.IS_LINUX = OS == 'Linux'
-- _G.IS_WINDOWS = OS:find 'Windows' and true or false
-- _G.IS_WSL = IS_LINUX and uname.release:find 'Microsoft' and true or false