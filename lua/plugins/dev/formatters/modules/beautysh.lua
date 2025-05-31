local M = {}

M.format = function()
	local filepath = vim.api.nvim_buf_get_name(0)

	vim.fn.jobstart({ "beautysh", "--indent-size", "4", filepath }, {
		on_exit = function()
			vim.schedule(function()
				vim.cmd("edit!")
				vim.cmd("normal! zz")
			end)
		end,
	})

	return nil
end

return M
