local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config"),
				},
				checkThirdParty = false,
				preloadFileSize = 150,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
