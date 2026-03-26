return {
  "mattn/emmet-vim",
  init = function()
    -- Replaces <C-y> with <leader>xe.
    -- To expand an abbreviation, you will now press: <leader>xe,
    vim.g.user_emmet_leader_key = "<leader>xe"
  end,
}
