vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.relativenumber = true

-- Python provider
-- vim.g.python3_host_prog = vim.env.HOME .. '/.pyenv/versions/py3nvim/bin/python'
-- Used 'uv venv' to create virtualenv
vim.g.python3_host_prog = vim.fn.stdpath 'data' .. '/.venv/bin/python3'
