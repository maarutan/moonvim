local border = require("core.options").border

local function smoothScroll(key, delay, stop_int)
	local timer = vim.loop.new_timer()
	local counter = 0
	timer:start(
		0,
		delay,
		vim.schedule_wrap(function()
			counter = counter + 1
			vim.cmd("normal! " .. key)
			if counter >= stop_int then
				timer:stop()
				timer:close()
			end
		end)
	)
end

local function scroll_down(picker)
	smoothScroll("j", 30, 3)
end

local function scroll_up(picker)
	smoothScroll("k", 30, 3)
end

return {
	focus = "input",
	ui_select = false,
	layout = {
		preset = "telescope",
		reverse = true,
		layout = {
			box = "horizontal",
			backdrop = true,
			width = 0.8,
			height = 0.9,
			border = border,
			{
				box = "vertical",
				{ win = "list", title = " Results ", title_pos = "center", border = border },
				{
					win = "input",
					height = 1,
					border = border,
					title = "{title} {live} {flags}",
					title_pos = "center",
				},
			},
			{
				win = "preview",
				title = "{preview:Preview}",
				width = 0.60,
				border = border,
				title_pos = "center",
			},
		},
	},

	actions = {
		scroll_down = scroll_down,
		scroll_up = scroll_up,
	},

	list = {
		keys = {
			["<C-d>"] = "scroll_down",
			["<C-u>"] = "scroll_up",
		},
	},
	input = {
		keys = {
			["<C-d>"] = "scroll_down",
			["<C-u>"] = "scroll_up",
		},
	},
}
