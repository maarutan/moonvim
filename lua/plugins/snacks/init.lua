local path = "plugins.snacks.modules."
local r = require

require("snacks").setup({
	scroll = r(path .. "scroll"),
	dashboard = r(path .. "dashboard"),
	indent = r(path .. "indent"),
	-- input     = r(path .. "input"),
	notifier = r(path .. "notifier"),
	styles = r(path .. "styles"),
	image = r(path .. "image"),
	picker = r(path .. "picker"),
})
