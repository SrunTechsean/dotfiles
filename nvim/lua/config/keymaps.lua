-- Key mapping for buffer switching
-- Leader mappings (<leader>n, <leader>p, <leader>d)
vim.keymap.set("n", "<leader>n", ":bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>p", ":bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>d", ":bdelete<cr>", { desc = "Delete Buffer" })

vim.keymap.set({ "n", "t" }, "<C-/>", function()
  Snacks.terminal.toggle(nil, { cwd = vim.fn.expand("%:p:h") })
end)
