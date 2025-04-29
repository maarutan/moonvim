require("notify").setup({
	stages = "fade_in_slide_out",
	background_colour = "#000000",
	timeout = 1000,
	minimum_width = 20,
	max_width = 40,
	max_height = 10,
	render = "wrapped-compact",
	top_down = true,
	time_formatn = {
		notification = "  %I:%M %p",
		notification_history = "  %Y-%m-%d %I:%M %p",
	},
	on_open = function(win)
		vim.api.nvim_win_set_config(win, { border = "double" })
	end,
	icons = {
		ERROR = "󰅚",
		WARN = "󰀪",
		INFO = "",
		DEBUG = "",
		TRACE = "󰌶",
	},
	level = vim.log.levels.WARN,
})
