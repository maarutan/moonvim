local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

if not configs.django_template_language_server then
	configs.django_template_language_server = {
		default_config = {
			cmd = { "djlsp" },
			filetypes = { "htmldjango" },
			root_dir = require("lspconfig.util").root_pattern("manage.py", ".git"),
			-- init_options = {
			-- 	django_settings_module = "your_project.settings",
			-- 	docker_compose_file = "docker-compose.yml",
			-- 	docker_compose_service = "django",
			-- },
		},
	}
end

lspconfig.django_template_language_server.setup({
	capabilities = capabilities,
})
