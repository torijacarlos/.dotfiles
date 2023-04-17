local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      -- Rust tools default rec
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, bufopts)
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, bufopts)

      -- My keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, bufopts)

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
    end,
  },
})
