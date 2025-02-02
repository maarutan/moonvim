local function is_kitty()
	return os.getenv("KITTY_WINDOW_ID") ~= nil
end

if is_kitty() then
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			os.execute("kitty @ set-spacing padding=0")
		end,
	})

	vim.api.nvim_create_autocmd("VimLeave", {
		callback = function()
			os.execute("kitty @ set-spacing padding=default")
		end,
	})
end
