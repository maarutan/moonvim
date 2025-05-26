_G.select_all_executed = false

local function select_all()
	_G.select_all_executed = true

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	vim.cmd("normal! ggVG")

	local restore_group = vim.api.nvim_create_augroup("SelectAllRestoreGroup", { clear = true })

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = restore_group,
		pattern = "*:*",
		callback = function()
			if _G.select_all_executed then
				vim.api.nvim_win_set_cursor(0, { row, col })
				_G.select_all_executed = false
				vim.api.nvim_del_augroup_by_id(restore_group)
			end
		end,
		once = true,
	})

	vim.cmd("normal! zz")
end

vim.api.nvim_create_user_command("SelectAll", select_all, {})
