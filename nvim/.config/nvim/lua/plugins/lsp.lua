vim.pack.add({
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
})

require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'clangd', 'ols', 'gopls', 'pylsp' },
})

local lsp_attach = function(client, buffer)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buffer, desc = 'Go to definition' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = buffer, desc = 'Go to implementation' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = buffer, desc = 'Go to references' })
  vim.keymap.set('n', 'gf', vim.lsp.buf.format, { buffer = buffer, desc = 'Format' })
  vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { buffer = buffer, desc = 'Diagnostic float' })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
})

local config = vim.lsp.config
local capabilities = require('cmp_nvim_lsp').default_capabilities()

config.lua_ls = {
  on_attach = lsp_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  },
}
vim.lsp.enable('lua_ls')

config.clangd = {
  on_attach = lsp_attach,
  capabilities = capabilities,
}
vim.lsp.enable('clangd')

config.ols = {
  on_attach = lsp_attach,
  capabilities = capabilities,
}
vim.lsp.enable('ols')

config.gopls = {
  on_attach = lsp_attach,
  capabilities = capabilities,
}
vim.lsp.enable('gopls')

config.pylsp = {
  on_attach = lsp_attach,
  capabilities = capabilities,
}
vim.lsp.enable('pylsp')