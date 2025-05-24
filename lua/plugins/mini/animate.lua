local animate = require("mini.animate")

animate.setup({
	resize = {
		enable = true,
		timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
	},
	open = {
		enable = true,
		timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
	},
	close = {
		enable = true,
		timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
	},
})
