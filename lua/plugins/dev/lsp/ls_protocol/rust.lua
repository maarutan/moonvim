local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		["rust-analyzer"] = {
			checkOnSave = { command = "check" },
		},
	},
})
