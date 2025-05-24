---@class snacks.scroll.Config
---@field animate snacks.animate.Config|{}
---@field animate_repeat snacks.animate.Config|{}|{delay:number}
return {
	animate = {
		duration = { step = 5, total = 350 },
		easing = "linear",
	},

	-- faster animation when repeating scroll after delay
	animate_repeat = {
		delay = 1, -- delay in ms before using the repeat animation
		duration = { step = 30, total = 300 },
		easing = "linear",
	},

	filter = function(buf)
		local disable_buf = {
			"terminal",
		}

		for _, bt in ipairs(disable_buf) do
			if vim.bo[buf].buftype == bt then
				return false
			end
		end

		return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false
	end,
}
