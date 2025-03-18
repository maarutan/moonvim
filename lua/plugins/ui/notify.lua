require("notify").setup({
	stages = "fade_in_slide_out",
	background_colour = "#000000",
	timeout = 1000,
	minimum_width = 20,
	max_width = 40,
	max_height = 10,
	render = "minimal",
	top_down = true,
	fps = 144,
	time_formats = {
		notification = "  %I:%M %p",
		notification_history = "  %Y-%m-%d %I:%M %p",
	},
	icons = {
		ERROR = "",
		WARN = "",
		INFO = "",
		DEBUG = "",
		TRACE = "✎",
	},
	level = vim.log.levels.WARN,
})
