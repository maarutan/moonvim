local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.nil_ls.setup({
	cmd = { "nil" },
	filetypes = { "nix" },
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern("flake.nix", "shell.nix", "configuration.nix", "disko.nix"),
})
