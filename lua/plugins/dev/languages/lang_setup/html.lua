local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.html.setup({
	capabilities = capabilities,
	filetypes = { "html", "htmldjango", "blade", "ejs" },
	init_options = {
		provideFormatter = true,
	},
	root_dir = lspconfig.util.root_pattern("package.json", "node_modules", ".git"),
})
