local on_attach = function(client, bufnr)
    -- Mappings.
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, bufopts)

    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

-- Setup lspconfig
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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

require("autoclose").setup()

vim.api.nvim_create_autocmd('FileType', {
	desc = 'STFU and thank you',
	pattern = { 'c', 'cpp' },
	callback = function (_)
        vim.diagnostic.config({virtual_text = false})
	end,
})






