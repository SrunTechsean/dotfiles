return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      accept = { auto_brackets = { enabled = false } },
      menu = {
        auto_show = true,
        max_height = 10,
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      transform_items = function(_, items)
        return items
      end,
      min_keyword_length = 1,
    },

    keymap = {
      preset = "default",
      -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-CR>"] = { "select_and_accept", "fallback" },

      ["<Esc>"] = {
        function(cmp)
          cmp.cancel()
          vim.cmd("stopinsert")
        end,
      },
    },
  },
}
