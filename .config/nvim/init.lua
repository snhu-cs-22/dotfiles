-- Source a old .vimrc
vim.cmd('source ~/.vimrc')

vim.o.winborder = "rounded"

-- Config Neovim/Lua-based plugins
require('config.plugins.treesitter')
