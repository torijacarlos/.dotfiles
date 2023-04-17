vim.go.showmatch = true
vim.go.wildmode = 'lastused,longest,list'
vim.opt.colorcolumn = "120"
vim.opt.signcolumn = "yes"


vim.o.clipboard = 'unnamedplus'
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.syntax = 'on'
vim.o.tabstop = 4
vim.o.scrolloff = 8

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.wo.cursorlineopt = "line"

vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.swapfile = false
vim.bo.wrapmargin = 100


require('mappings')
require('plugins')
require('indentation')
