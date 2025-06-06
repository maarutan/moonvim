local function is_kitty()
	local kitty_id = os.getenv("KITTY_WINDOW_ID")
	return kitty_id ~= nil and kitty_id ~= ""
end

if is_kitty() then
	local function apply_kitty_settings()
		-- os.execute("kitty @ set-font-size 13.5")
		os.execute("kitty @ set-spacing padding=0")
		-- os.execute("kitty @ set-background-opacity 1")
	end

	local function reset_kitty_settings()
		-- os.execute("kitty @ set-font-size 0")
		os.execute("kitty @ set-spacing padding=default")
	end

	vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "WinEnter", "TabEnter" }, {
		callback = apply_kitty_settings,
	})

	vim.api.nvim_create_autocmd("VimLeave", {
		callback = reset_kitty_settings,
	})

	local ok, kitty_scroll = pcall(require, "kitty-scrollback")
	if ok then
		vim.keymap.set({ "n" }, "q", "Plug(KsbCloseOrQuitAll)", {})
		kitty_scroll.setup()
	else
		vim.schedule(function()
			vim.notify("Warning: kitty-scrollback.nvim not found", vim.log.levels.WARN)
		end)
	end
end
