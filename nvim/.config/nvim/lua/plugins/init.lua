vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      vim.cmd('TSUpdateSync')
    end

    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.fn.system({ 'make' }, { cwd = ev.data.path })
    end
  end,
  desc = 'Handle plugin build steps after install/update',
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local fzf_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
    local so_file = fzf_path .. '/build/libfzf.so'
    if vim.fn.filereadable(so_file) == 0 then
      vim.fn.system({ 'make' }, { cwd = fzf_path })
    end
  end,
  desc = 'Build telescope-fzf-native if library missing',
})

require('plugins.lsp')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.cmp')
require('plugins.tree')
require('plugins.statusline')
require('plugins.autoclose')
require('plugins.surround')
require('plugins.theme')
require('plugins.image')
require('plugins.diffview')