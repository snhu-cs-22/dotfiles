-- Source a old .vimrc
vim.cmd('source ~/.vimrc')

vim.o.winborder = "rounded"

vim.api.nvim_create_autocmd('CursorHold', {
  pattern = { '*' },
  callback = vim.diagnostic.open_float
})

-- Config Neovim/Lua-based plugins
require('mason').setup()

require('config.plugins.treesitter')

vim.lsp.enable('rust-analyzer')
vim.lsp.enable('python-lsp-server')
