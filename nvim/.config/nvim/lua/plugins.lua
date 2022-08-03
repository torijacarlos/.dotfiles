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
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("packer-compile", { clear = true }),
    pattern = "plugins.lua",
    callback = function()
        vim.cmd("source % | PackerCompile")
    end,
})

--- Autoformat files on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("torijacarlos", { clear = true }),
    pattern = { "*.js" },
    callback = function()
        vim.lsp.buf.formatting_sync()
    end
})

--- startup and add configure plugins
packer.startup(function()
    use('wbthomason/packer.nvim')
    use('EdenEast/nightfox.nvim')
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

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

