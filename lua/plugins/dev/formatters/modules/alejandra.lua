local M = {}

M.format = function()
	local filepath = vim.api.nvim_buf_get_name(0)

	vim.fn.jobstart({ "alejandra", filepath }, {
		on_exit = function()
			vim.schedule(function()
				vim.cmd("edit!")
			end)
		end,
	})

	return nil
end

return M
