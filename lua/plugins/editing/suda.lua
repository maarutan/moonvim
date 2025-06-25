vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		if vim.bo.readonly and vim.bo.modifiable then
			vim.schedule(function()
				vim.notify("The file is opened as readonly.\nTrying to reload via :SudaRead...", vim.log.levels.WARN, {
					title = "Suda: ",
					timeout = 10000,
					icon = " ",
				})
				vim.cmd("SudaRead")
			end)
		end
	end,
})
