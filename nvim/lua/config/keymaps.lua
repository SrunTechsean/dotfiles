-- Key mapping for buffer switching
-- Leader mappings (<leader>n, <leader>p, <leader>d)
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

vim.keymap.set({ "n", "t" }, "<C-t>", function()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_win_hide(0)
        return
    end
    local cwd = vim.fn.expand("%:p:h")
    if cwd == "" or cwd:match("^%a+://") then
        cwd = vim.fn.getcwd()
    end
    Snacks.terminal.toggle(nil, { id = "file_term", cwd = cwd })
end, { desc = "Terminal (Current File)" })
