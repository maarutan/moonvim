local M = {}

M.format = function()
	local filepath = vim.api.nvim_buf_get_name(0)

	vim.fn.jobstart({ "rustfmt", filepath }, {
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				vim.schedule(function()
					vim.cmd("edit!")
					vim.cmd("normal! zz")
				end)
			end
		end,
		stdout_buffered = true,
		stderr_buffered = true,
	})
end

return M
