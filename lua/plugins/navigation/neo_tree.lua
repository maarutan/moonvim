local border = require("core.options").border
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
	},
})

require("neo-tree").setup({
	retain_hidden_root_indent = true, -- IF the root node is hidden, keep the indentation anyhow.
	hide_root_node = true, -- Hide the root node.
	popup_border_style = border,

	filesystem = {
		filtered_items = {
			hide_by_name = {
				--"node_modules"
				".venv",
				".venv",
				"venv",
				"pyrightconfig.json",
				".pyrightconfig.json",
				"node_modules",
			},
		},

		window = {
			position = "left",
			width = 30,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {

				["L"] = "set_root",
				["H"] = "navigate_up",
				["."] = "abs_path",
				["D"] = "diff_files",

				["<C-h>"] = "toggle_hidden",

				["f"] = "fuzzy_finder",
				["P"] = {
					"toggle_preview",
					config = {
						use_float = true,
						use_image_nvim = true,
					},
				},

				["l"] = "open",
			},
		},
	},

	source_selector = {
		winbar = false,
		content_layout = "center",
		tabs_layout = "equal",
		show_separator = true,
		sources = {
			{ source = "filesystem", display_name = "  File" },
			{ source = "git_status", display_name = "󰊢  Git" },
			{ source = "buffers", display_name = "󱚀  Buffers" },
		},
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(arg)
				vim.cmd([[
              setlocal relativenumber
            ]])
			end,
		},
	},

	commands = {
		diff_files = function(state)
			local node = state.tree:get_node()
			local log = require("neo-tree.log")
			state.clipboard = state.clipboard or {}
			if diff_Node and diff_Node ~= tostring(node.id) then
				local current_Diff = node.id
				require("neo-tree.utils").open_file(state, diff_Node, open)
				vim.cmd("vert diffs " .. current_Diff)
				log.info("Diffing " .. diff_Name .. " against " .. node.name)
				diff_Node = nil
				current_Diff = nil
				state.clipboard = {}
				require("neo-tree.ui.renderer").redraw(state)
			else
				local existing = state.clipboard[node.id]
				if existing and existing.action == "diff" then
					state.clipboard[node.id] = nil
					diff_Node = nil
					require("neo-tree.ui.renderer").redraw(state)
				else
					state.clipboard[node.id] = { action = "diff", node = node }
					diff_Name = state.clipboard[node.id].node.name
					diff_Node = tostring(state.clipboard[node.id].node.id)
					log.info("Diff source file " .. diff_Name)
					require("neo-tree.ui.renderer").redraw(state)
				end
			end
		end,

		nil_func = function()
			return nil
		end,

		abs_path = function(state)
			local node = state.tree:get_node()
			if node and node.type == "file" then
				local file_path = node:get_id()
				local last_notification_id = nil

				-- Show file path function
				local function show_file_path()
					if file_path == "" then
						file_path = "File doesn't exist"
					else
						-- Replace the home directory path with ~
						file_path = file_path:gsub(vim.env.HOME, "~")
					end

					-- Display the file path with notification
					last_notification_id = vim.notify(file_path, vim.log.levels.WARN, {
						title = "Current File 🚀",
						replace = last_notification_id, -- Correctly refer to the variable
						timeout = 3000, -- Show notification for 3 seconds
					})
				end

				-- Call the function to show the file path
				show_file_path()
			end
		end,
		open_and_clear_filter = function(state)
			local node = state.tree:get_node()
			if node and node.type == "file" then
				local file_path = node:get_id()
				-- reuse built-in commands to open and clear filter
				local cmds = require("neo-tree.sources.filesystem.commands")
				cmds.open(state)
				cmds.clear_filter(state)
				-- reveal the selected file without focusing the tree
				require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
			end
		end,
	},

	default_component_configs = {

		symbols = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},

		indent = {
			indent_size = 3,
			padding = 2, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└─",
			highlight = "NeoTreeIndentMarker",

			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},

		git_status = {
			symbols = {
				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "", -- this can only be used in the git_status source
				renamed = "", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
	},
})
