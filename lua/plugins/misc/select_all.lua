---@diagnostic disable: deprecated
_G.select_all_executed = false

local function select_all()
	_G.select_all_executed = true

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	local original_line_count = vim.api.nvim_buf_line_count(0)

	vim.cmd("normal! ggVG")

	local restore_group = vim.api.nvim_create_augroup("SelectAllRestoreGroup", { clear = true })

	vim.api.nvim_create_autocmd("ModeChanged", {
		group = restore_group,
		pattern = "*:*",
		callback = function()
			if not _G.select_all_executed then
				return
			end
			_G.select_all_executed = false
			pcall(vim.api.nvim_del_augroup_by_id, restore_group)

			local line_count = vim.api.nvim_buf_line_count(0)

			local target_row = math.min(row, line_count)
			local ok = pcall(vim.api.nvim_win_set_cursor, 0, { target_row, col })
		end,
		once = true,
	})

	vim.cmd("normal! zz")
end

vim.api.nvim_create_user_command("SelectAll", select_all, {})
