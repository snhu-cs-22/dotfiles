-- Source a old .vimrc
vim.cmd('source ~/.vimrc')

vim.o.winborder = "rounded"

-- Config Neovim/Lua-based plugins
require('mason').setup()

require('config.plugins.treesitter')
