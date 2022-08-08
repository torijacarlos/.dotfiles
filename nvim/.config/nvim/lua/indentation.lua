--- Special indentation
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("special-indentation", { clear = true }),
    pattern = { "terraform" },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
        vim.bo.tabstop = 2
    end
})
