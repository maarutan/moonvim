local function select_all()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.cmd("normal! ggVG")

	local function restore_cursor()
		vim.api.nvim_win_set_cursor(0, { row, col })
	end

	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = restore_cursor,
		once = true,
	})

	vim.api.nvim_create_autocmd("ModeChanged", {
		pattern = "*:[vV\x16]*",
		callback = function()
			local mode = vim.api.nvim_get_mode().mode
			if mode == "n" then
				restore_cursor()
			end
		end,
		once = true,
	})

	local keys = { "<Esc>", "<C-c>", "i", "a", "I", "A", "o", "O" }
	for _, key in ipairs(keys) do
		vim.api.nvim_buf_set_keymap(
			0,
			"v",
			key,
			[[<Esc>:lua (function() vim.api.nvim_win_set_cursor(0, {]] .. row .. [[, ]] .. col .. [[}) end)()<CR>]],
			{ noremap = true, silent = true }
		)
	end
	vim.cmd("normal! zz")
end

vim.api.nvim_create_user_command("SelectAll", function()
	select_all()
end, {})
