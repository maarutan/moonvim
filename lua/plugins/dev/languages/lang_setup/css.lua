local lspconfig = require("lspconfig")

lspconfig.cssls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
		},
		less = {
			validate = true,
		},
	},
	filetypes = {
		"css",
		"scss",
		"less",
		"html",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "node_modules", ".git"),
})
