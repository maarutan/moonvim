return {
	animate = {
		duration = { step = 15, total = 250 },
		easing = "linear",
	},
	animate_repeat = {
		delay = 100,
		duration = { step = 5, total = 50 },
		easing = "linear",
	},
	filter = function(buf)
		return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
	end,
}
