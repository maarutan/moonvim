function create_new_buffer()
	local new_name = vim.fn.input("New file name: ", "")
	if new_name == "" then
		vim.notify("creation canceled.", vim.log.levels.WARN, {
			icon = "ℹ️",
			title = "NewBuffer",
		})
		return
	end

	if vim.fn.filereadable(new_name) == 1 then
		vim.notify("Error: File exists.", vim.log.levels.ERROR, {
			icon = "🚨",
			title = "NewBuffer",
		})
		return
	end

	local ok, err = pcall(function()
		vim.cmd("edit " .. new_name)
		vim.cmd("setlocal buftype=")
	end)

	if not ok then
		vim.notify("Error creating: " .. err, vim.log.levels.ERROR, {
			icon = "🚨",
			title = "NewBuffer",
		})
		return
	end

	vim.notify("New buffer created: " .. new_name, vim.log.levels.WARN, {
		icon = "😄",
		title = "NewBuffer",
	})
end

return {
	width = 50,
	row = nil, -- dashboard position. nil for center
	col = nil, -- dashboard position. nil for center
	pane_gap = 10, -- empty columns between vertical panes
	autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
	preset = {
		pick = nil,
		keys = {
			{
				icon = "󰉖    ",
				icon_hl = "Title",
				desc = "Open Directory",
				desc_hl = "String",
				key = "d",
				keymap = "      SPC w d",
				key_hl = "Number",
				action = function()
					require("telescope").extensions.file_browser.file_browser({
						prompt_title = "Select Directory",
						cwd = "~", -- Initial directory
						attach_mappings = function(_, map)
							local actions = require("telescope.actions")
							map("i", "<CR>", function(prompt_bufnr)
								local selected_path = require("telescope.actions.state").get_selected_entry().path
								actions.close(prompt_bufnr)
								vim.cmd("cd " .. selected_path)
								vim.cmd("edit .")
							end)
							return true
						end,
					})
				end,
			},
			{
				icon = "󰈞    ",
				icon_hl = "Title",
				desc = "Find and open file",
				desc_hl = "String",
				key = "f",
				keymap = "         SPC f f",
				key_hl = "Number",
				action = function()
					require("telescope.builtin").find_files({
						find_command = { "fd", "--type", "f" },
						attach_mappings = function(_, map)
							local actions = require("telescope.actions")
							local action_state = require("telescope.actions.state")
							map("i", "<CR>", function(prompt_bufnr)
								local selected_entry = action_state.get_selected_entry()

								if not selected_entry then
									print("No file selected!")
									return
								end

								local filepath = selected_entry.path
								local file_dir = vim.fn.fnamemodify(filepath, ":p:h")

								actions.close(prompt_bufnr)

								vim.cmd("cd " .. file_dir)
								vim.cmd("edit " .. vim.fn.fnameescape(filepath))
							end)
							return true
						end,
					})
				end,
			},
			{
				icon = "    ",
				icon_hl = "Title",
				desc = "Git Branches",
				desc_hl = "String",
				key = "b",
				keymap = "         SPC g b",
				key_hl = "Number",
				action = function()
					if vim.fn.isdirectory(".git") == 1 then
						require("telescope.builtin").git_branches()
					else
						vim.notify("No Git repository found.", vim.log.levels.WARN, {
							title = "Git",
							icon = "󰊢",
						})
					end
				end,
			},
			{
				icon = "    ",
				icon_hl = "Title",
				desc = "Recent files",
				desc_hl = "String",
				key = "r",
				keymap = "         SPC f r",
				key_hl = "Number",
				action = function()
					local action_state = require("telescope.actions.state")
					local telescope = require("telescope.builtin")

					telescope.oldfiles({
						attach_mappings = function(prompt_bufnr, map)
							local function open_and_change_dir()
								local selection = action_state.get_selected_entry()
								if not selection then
									print("[Telescope] No selection")
									return
								end
								local filepath = selection.path or selection.filename
								if filepath then
									local dir = vim.fn.fnamemodify(filepath, ":h")
									vim.cmd("cd " .. dir)
									vim.cmd("e! " .. filepath)
								end

								if vim.fn.bufexists(prompt_bufnr) == 1 then
									-- Используем команду Bdelete для закрытия буфера
									vim.cmd("Bdelete " .. prompt_bufnr)
								end
							end

							map("i", "<CR>", open_and_change_dir)
							map("n", "<CR>", open_and_change_dir)
							return true
						end,
					})
				end,
			},
			{
				icon = "    ",
				icon_hl = "Title",
				desc = "New file",
				desc_hl = "String",
				key = "n",
				keymap = "         SPC b n",
				key_hl = "Number",
				action = create_new_buffer,
			},
			{
				icon = "    ",
				icon_hl = "Title",
				desc = "Open Neovim Config",
				desc_hl = "String",
				key = "o",
				keymap = "         SPC o c",
				key_hl = "Number",
				action = ":cd ~/.config/nvim | edit init.lua",
			},
			{
				desc = "                      󰩈 Quit [q]", -- Centered text
				desc_hl = "String",
				key = "q",
				keymap = "         SPC q _",
				key_hl = "Number",
				action = ":quit", -- Quit Neovim command
			},
		},
		header = [[
███╗   ███╗ ██████╗  ██████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗ ████║██╔═══██╗██╔═══██╗████╗  ██║██║   ██║██║████╗ ████║
██╔████╔██║██║   ██║██║   ██║██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╔╝██║██║   ██║██║   ██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]],
	},
	formats = {
		icon = function(item)
			if item.file and (item.icon == "file" or item.icon == "directory") then
				return M.icon(item.file, item.icon)
			end
			return { item.icon, width = 2, hl = "icon" }
		end,
		footer = { "%s", align = "center" },
		header = { "%s", align = "center" },
		file = function(item, ctx)
			local fname = vim.fn.fnamemodify(item.file, ":~")
			fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
			if #fname > ctx.width then
				local dir = vim.fn.fnamemodify(fname, ":h")
				local file = vim.fn.fnamemodify(fname, ":t")
				if dir and file then
					file = file:sub(-(ctx.width - #dir - 2))
					fname = dir .. "/…" .. file
				end
			end
			local dir, file = fname:match("^(.*)/(.+)$")
			return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
		end,
	},
	sections = {
		{ section = "header" },
		{ section = "keys", gap = 1, padding = 1 },
		{ section = "startup" },
		{
			section = "terminal",
			cmd = "ascii-image-converter ~/Pictures/Profile/user.jpg -C -c ",
			pane = 2,
			indent = 1,
			random = 9999999999999999999,
			height = 25,
		},
	},
}
