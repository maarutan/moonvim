local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
require("plugins.dev.snippets.pyright") -- pyright snippets
require("plugins.dev.snippets.lua") -- lua snippets

luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})
