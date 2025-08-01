local border = require("core.options").border
require("noice").setup({
	lsp = {
		signature = { opts = { size = { max_height = 15, max_width = 90 }, border = border } },
		hover = { opts = { size = { max_height = 20, max_width = 60 }, border = border } },
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	cmdline = {
		enabled = true,
	},
	--- lazy ---
	-- presets = {
	-- 	bottom_search = true, -- use a classic bottom cmdline for search
	-- 	command_palette = true, -- position the cmdline and popupmenu together
	-- 	long_message_to_split = true, -- long messages will be sent to a split
	-- 	inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 	lsp_doc_border = false, -- add a border to hover docs and signature help
	-- },
	--- lazy ---

	progress = {},

	routes = {
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
				},
			},
			view = "mini",
		},
	},

	views = {
		cmdline_popup = {
			border = {
				style = border,
				-- padding = { 1, 1 },
			},
			position = {
				row = "37%",
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
		},
		mini = {
			position = {
				row = "97%",
				col = "100%",
			},
			size = {
				width = "auto",
				height = "auto",
			},
		},
	},
})

-- vim.cmd([[
--  highlight NoiceMini guifg=#62667B
-- ]])
--
