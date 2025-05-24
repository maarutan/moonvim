local border = require("core.options").border
local inputs = require("neo-tree.ui.inputs")
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

local function witch(command)
	return vim.fn.executable(command) == 1
end

local function is_cursor_bottom()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)
	return current_line == total_lines
end

local function is_cursor_top()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	return current_line == 1
end

local function smoothScroll(key, delay, stop_int)
	local timer = vim.loop.new_timer()
	local line_count = vim.api.nvim_buf_line_count(0)
	local counter = 0
	timer:start(
		0,
		delay,
		vim.schedule_wrap(function()
			counter = counter + 1
			vim.cmd("normal! " .. key)

			if is_cursor_bottom() then
				vim.cmd("normal! gg")
			elseif is_cursor_top() then
				vim.cmd("normal! G")
			end

			if counter == stop_int then
				counter = 0
				timer:stop()
				timer:close()
			end
		end)
	)
end

local function up_down_handler(up)
	local before = vim.api.nvim_win_get_cursor(0)[1]

	if up then
		vim.cmd("normal! k")
	else
		vim.cmd("normal! j")
	end

	local after = vim.api.nvim_win_get_cursor(0)[1]
	local total = vim.api.nvim_buf_line_count(0)

	if before == 1 and up then
		vim.cmd("normal! G")
	elseif before == total and not up then
		vim.cmd("normal! gg")
	end
end

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
				-- ["r"] = "rename",

				["<C-u>"] = "scrollup",
				["<C-d>"] = "scrolldown",

				["d"] = "trash",
				["u"] = "restore",

				["k"] = "up",
				["j"] = "down",

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
		{
			event = require("neo-tree.events").FILE_OPENED,
			handler = function()
				vim.api.nvim_create_autocmd("BufReadPost", {
					callback = function()
						for _, buf in ipairs(vim.api.nvim_list_bufs()) do
							if
								vim.api.nvim_buf_get_name(buf) == ""
								and vim.api.nvim_buf_get_option(buf, "buftype") == ""
							then
								vim.api.nvim_buf_delete(buf, { force = true })
							end
						end
					end,
				})
			end,
		},
		{
			event = require("neo-tree.events").FILE_MOVED,
			handler = function(data)
				require("snacks.rename").on_rename_file(data.source, data.destination)
			end,
		},
		{
			event = require("neo-tree.events").FILE_RENAMED,
			handler = function(data)
				require("snacks.rename").on_rename_file(data.source, data.destination)
			end,
		},
	},

	commands = {
		scrollup = function(state)
			smoothScroll("k", 30, 3)
		end,

		scrolldown = function(state)
			smoothScroll("j", 30, 3)
		end,

		up = function(state)
			up_down_handler(true)
		end,

		down = function(state)
			up_down_handler(false)
		end,

		trash = function(state)
			if witch("trash-put") then
				local node = state.tree:get_node()
				if node.type == "message" then
					return
				end
				local _, name = require("neo-tree.utils").split_path(node.path)
				local msg = string.format("Are you sure you want to trash '%s'?", name)
				inputs.confirm(msg, function(confirmed)
					if not confirmed then
						return
					end
					vim.fn.system({ "trash-put", node.path })
					require("neo-tree.sources.manager").refresh(state)
				end)
			else
				vim.notify("`trash-cli`: no found", vim.log.levels.WARN, { icon = "🚮" })
			end
		end,

		restore = function(state)
			vim.cmd("BRestore")
			require("neo-tree.sources.manager").refresh(state)
		end,

		abs_path = function(state)
			local node = state.tree:get_node()
			if node and (node.type == "file" or node.type == "directory") then
				local file_path = node:get_id()
				local last_notification_id = nil

				local function show_file_path()
					if file_path == "" then
						file_path = "Path doesn't exist"
					else
						file_path = file_path:gsub(vim.env.HOME, "~")
					end

					last_notification_id = vim.notify(file_path, vim.log.levels.INFO, {
						title = (node.type == "file" and "Current File 📄" or "Current Directory 📁"),
						replace = last_notification_id,
						timeout = 4000,
					})
				end

				show_file_path()
			end
		end,

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
