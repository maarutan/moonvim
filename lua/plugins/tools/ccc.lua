local ccc = require("ccc")
ccc.setup({
	highlighter = {
		auto_enable = true,
	},
	pickers = {
		ccc.picker.ansi_escape(),
	},
})
