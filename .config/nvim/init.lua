-- Source a old .vimrc
vim.cmd('source ~/.vimrc')

vim.o.winborder = "rounded"

vim.diagnostic.config({
  jump = { float = true },
  severity_sort = true,
  virtual_text = true,
  underline = true
})

-- Config Neovim/Lua-based plugins
require('config.plugins.mason')
require('config.plugins.treesitter')
require('config.plugins.blink')
