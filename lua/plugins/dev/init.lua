-- programming language
require("plugins.dev.lsp.init")

-- treesitter
require("plugins.dev.treesitter.context")
require("plugins.dev.treesitter.sintax_highlight")

-- fromatters
require("plugins.dev.formatters.init")

-- Mason
require("plugins.dev.mason")

-- snippets
require("plugins.dev.snippets.luasnip")

-- keymaps
require("plugins.dev.keymaps")

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
