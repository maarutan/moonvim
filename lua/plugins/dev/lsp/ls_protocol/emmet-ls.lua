local lspconfig = require("lspconfig")

lspconfig.emmet_ls.setup({
	filetypes = {
		"html",
		"css",
		"markdown",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"blade.php",
		"htmldjango",
	},

	init_options = {
		emmet = {
			showExpandedAbbreviation = "always",
			showAbbreviationSuggestions = true,
			showSuggestionsAsSnippets = true,
		},
	},
})
