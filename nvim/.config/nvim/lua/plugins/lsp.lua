return {
    {
        "neovim/nvim-lspconfig",
        config = function() 
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

            local config =require('lspconfig') 

            config.pylsp.setup{on_attach=lsp_attach}
            config.clangd.setup{on_attach=lsp_attach}

        end
    }
}

