local luasnip = require("luasnip")

luasnip.add_snippets("lua", {
	luasnip.snippet("fn", {
		luasnip.text_node("function "),
		luasnip.insert_node(1, "name"),
		luasnip.text_node("()"),
		luasnip.insert_node(0),
		luasnip.text_node("end"),
	}),
})

return luasnip
