require("lspconfig").emmet_ls.setup({
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "pug",
    "typescriptreact",
  },
  init_options = {
    preferences = {},
    showAbbreviationSuggestions = true,
    showExpandedAbbreviation = "always", -- or "never"
    showSuggestionsAsSnippets = false,
    syntaxProfiles = {},
    variables = {},
  },
})
