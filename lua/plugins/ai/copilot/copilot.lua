-- ┌─┐┬┌┬┐┬ ┬┬ ┬┌┐   ┌─┐┌─┐┌─┐┬┬  ┌─┐┌┬┐
-- │ ┬│ │ ├─┤│ │├┴┐  │  │ │├─┘││  │ │ │
-- └─┘┴ ┴ ┴ ┴└─┘└─┘  └─┘└─┘┴  ┴┴─┘└─┘ ┴
-- Copyright (c) 2025 maarutan. \ Marat Arzymatov  All Rights Reserved.
-------------------------------------------------------------------------
require("copilot").setup({
	panel = {
		enabled = true,
		auto_refresh = false,
		keymap = {
			jump_prev = "[[",
			jump_next = "]]",
			accept = "<CR>",
			refresh = "gr",
			open = "<M-CR>",
		},
		layout = {
			position = "bottom", -- | top | left | right | horizontal | vertical
			ratio = 0.4,
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = false,
		hide_during_completion = true,
		debounce = 75,
		trigger_on_accept = true,
		keymap = {
			accept = "<C-i>",
			accept_word = false,
			accept_line = false,
			next = "<C-n>",
			prev = "<C-p>",
			dismiss = "<C-x>",
		},
	},
	filetypes = {
		-- yaml = false,
		-- markdown = false,
		-- help = false,
		-- gitcommit = false,
		-- gitrebase = false,
		-- hgcommit = false,
		-- svn = false,
		-- cvs = false,
		["."] = true,
	},
})

require("plugins.ai.copilot.copilot_chat")
require("plugins.ai.copilot.copilot_cmp")
