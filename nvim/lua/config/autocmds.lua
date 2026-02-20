-- Don't add new comment when new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Enable snacks image for specific file type
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(e)
    if vim.api.nvim_buf_is_valid(e.buf) then
      require("snacks.image.doc").attach(e.buf)
    end
  end,
})
