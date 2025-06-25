local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.django_template_language_server.setup({
	capabilities = capabilities,
	cmd = { "django-template-language-server", "--stdio" },
	filetypes = { "htmldjango" },
	settings = {
		django = {},
	},
})
