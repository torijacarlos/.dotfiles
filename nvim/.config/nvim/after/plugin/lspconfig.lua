local on_attach = function(client, bufnr)
    -- Mappings.
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, bufopts)

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)

    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, bufopts)
    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), 
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'vsnip', keyword_length = 3 },
    }, {
        { name = 'buffer', keyword_length = 3 },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer', keyword_length = 3 }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path', keyword_length = 3 }
    }, {
        { name = 'cmdline', keyword_length = 3 }
    })
})


-- Setup rust-tools
require("rust-tools").setup({
  server = {
    on_attach = on_attach,
  },
})

-- Setup lspconfig
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('lspconfig')['terraformls'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['tsserver'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['clangd'].setup{
    cmd = { "clangd", "--query-driver=/usr/bin/*-g++"},
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['pylsp'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['gopls'].setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
}

require("autoclose").setup()

vim.api.nvim_create_autocmd('FileType', {
	desc = 'STFU and thank you',
	pattern = { 'rust', 'c', 'cpp' },
	callback = function (_)
        vim.diagnostic.config({virtual_text = false})
	end,
})






