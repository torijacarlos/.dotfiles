require('config.lazy')

vim.keymap.set("n", "<leader>o", "<cmd>bp<cr>", bufopts)
vim.keymap.set("n", "<leader>p", "<cmd>bn<cr>", bufopts)

vim.go.showmatch = true
vim.go.swapfile = false
vim.go.wildmode = 'lastused,longest,list'
vim.o.colorcolumn = "100"
vim.o.signcolumn = "yes"

vim.o.clipboard = 'unnamedplus'
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.syntax = 'on'
vim.o.tabstop = 4
vim.o.scrolloff = 8
vim.o.list = true
vim.o.listchars = 'space:·,tab:~~'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"

vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.wrapmargin = 100

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
  
vim.opt.termguicolors = true
vim.opt.iskeyword:remove{ '_', '-' }
