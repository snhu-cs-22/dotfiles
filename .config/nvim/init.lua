-- Source a old .vimrc
vim.cmd('source ~/.vimrc')

vim.o.winborder = "rounded"

vim.diagnostic.config({
  virtual_text = true,
  underline = true
})

-- Config Neovim/Lua-based plugins
require('mason').setup()

require('config.plugins.treesitter')

vim.lsp.enable('rust-analyzer')
vim.lsp.enable('python-lsp-server')
