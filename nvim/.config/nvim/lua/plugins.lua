local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')

local packer = require('packer')
local util = require('packer.util')

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- Update installed packages automatically
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

--- Autoformat files on save
vim.cmd([[
  augroup TORIJACARLOS
    autocmd!
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
  augroup end
]])

--- startup and add configure plugins
packer.startup(function()
    use('wbthomason/packer.nvim')
    use('EdenEast/nightfox.nvim')

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    use('neovim/nvim-lspconfig')

    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    })

    use({
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    })
end)

