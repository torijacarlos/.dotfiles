local lsp_attach = function(client, buffer)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {
        buffer = buffer
    });
end

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
})

require('lspconfig').pylsp.setup{on_attach=lsp_attach}
require('lspconfig').clangd.setup{on_attach=lsp_attach}
