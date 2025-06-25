local ccc = require("ccc")
local border = require("core.options").border

ccc.setup({
	highlighter = {
		auto_enable = true,
	},
	pickers = {
		ccc.picker.ansi_escape(),
	},
	win_opts = { border = border }, -- var representing some custom border chars
})
