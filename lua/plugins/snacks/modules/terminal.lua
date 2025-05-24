return {
	bo = {
		filetype = "terminal",
	},
	wo = {},
	keys = {
		q = "hide",
		gf = function(self)
			local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
			if f == "" then
				Snacks.notify.warn("No file under cursor")
			else
				self:hide()
				vim.schedule(function()
					vim.cmd("e " .. f)
				end)
			end
		end,
		term_normal = {
			"<Esc>",
			function(self)
				self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
				if self.esc_timer:is_active() then
					self.esc_timer:stop()
					vim.cmd("stopinsert")
				else
					self.esc_timer:start(200, 0, function() end)
					return "<Esc>"
				end
			end,
			mode = "t",
			expr = true,
			desc = "Double escape to normal mode",
		},
	},
}
