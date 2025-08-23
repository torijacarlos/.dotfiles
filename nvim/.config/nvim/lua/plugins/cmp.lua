return {
    {"hrsh7th/cmp-buffer" },
    {"hrsh7th/cmp-path"   },
    {"hrsh7th/cmp-cmdline"},
    {
        "hrsh7th/nvim-cmp",
        config = function() 

            local cmp = require("cmp")

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                { name = 'buffer' }
              }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline', keyword_length = 3 }
              }),
              matching = { disallow_symbol_nonprefix_matching = false }
            })
        end

    },
}
