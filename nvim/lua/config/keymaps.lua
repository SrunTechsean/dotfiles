-- Key mapping for buffer switching
-- Leader mappings (<leader>n, <leader>p, <leader>d)
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

local _terminal_cwd = nil
vim.keymap.set({ "n", "t" }, "<C-t>", function()
  if not _terminal_cwd then
    local cwd = vim.fn.expand("%:p:h")
    _terminal_cwd = vim.fn.isdirectory(cwd) == 1 and cwd or vim.fn.getcwd()
  end
  Snacks.terminal.toggle(nil, { cwd = _terminal_cwd })
end, { desc = "Terminal (cwd)" })
