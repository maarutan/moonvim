local function is_kitty()
	local kitty_id = os.getenv("KITTY_WINDOW_ID")
	local id_num = tonumber(kitty_id)
	return id_num ~= nil and id_num >= 1
end

if is_kitty() then
	local function apply_kitty_settings()
		os.execute("kitty @ set-font-size 13.5")
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
		kitty_scroll.setup({
			callbacks = function()
				apply_kitty_settings()
			end,
			keymaps_enabled = true,
			restore_options = true,
			highlight_overrides = nil,
			status_window = {
				enabled = true,
				style_simple = true,
				autoclose = false,
				show_timer = false,
				icons = {
					kitty = "󰄛",
					heart = "󰣐", -- variants 󰣐 |  |  | ♥ |  | 󱢠 | 
					nvim = "", -- variants  |  |  | 
				},
			},
			paste_window = {
				highlight_as_normal_win = nil,
				filetype = "kitty-scrollback",
				hide_footer = false,
				winblend = 0,
				winopts_overrides = nil,
				footer_winopts_overrides = nil,
				yank_register = "",
				yank_register_enabled = true,
			},
			kitty_get_text = {
				ansi = false,
				extent = "all",
				clear_selection = true,
			},
			checkhealth = false,
			visual_selection_highlight_mode = "darken",
		})
	else
		vim.schedule(function()
			vim.notify("Warning: kitty-scrollback.nvim not found", vim.log.levels.WARN)
		end)
	end
end
