--- Special indentation
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("special-indentation", { clear = true }),
    pattern = { "terraform" },
    callback = function()
        vim.o.shiftwidth = 2
        vim.o.softtabstop = 2
        vim.o.tabstop = 2
    end
})
