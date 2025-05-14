local border = require("core.options").border
return {
	focus = "input",
	layout = {
		--- Use the default layout or vertical if the window is too narrow
		preset = "telescope", -- telescope default,sidebar , vertical -- select
		-- preset = function()
		--   return vim.o.columns >= 120 and "default" or "vertical"
		-- end,
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
		-- position = "bottom",
	},
}
