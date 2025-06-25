require("cinnamon").setup({
	-- Enable all provided keymaps
	keymaps = {
		basic = false,
		extra = true,
	},
	-- Only scroll the window
	options = { mode = "window" },
})
