-- ┬┌─┌─┐┬ ┬┌┐ ┬┌┐┌┌┬┐┬┌┐┌┌─┐┌─┐
-- ├┴┐├┤ └┬┘├┴┐││││ │││││││ ┬└─┐
-- ┴ ┴└─┘ ┴ └─┘┴┘└┘─┴┘┴┘└┘└─┘└─┘
-- Copyright (c) 2025 maarutan. \ Marat Arzymatov  All Rights Reserved.
-------------------------------------------------------------------------

-- Leader key
vim.g.mapleader = " " -- Set the leader key to space

local map = vim.keymap.set -- Set keymap
local noremap = { noremap = true } -- Default options
local silent = { silent = true } -- Default options
local opts = { noremap = true, silent = true } -- Default options
-- noremap - Don't remap the keys in the mapping.
-- silent - Don't echo the key sequence in the command line.

-- betteresc
map("i", "jk", "<Esc>", opts) -- fast escape
map("i", "jj", "<Esc>", opts) -- fast escape

-- Buffer focus
-- Buffer - it's window workspace
map("n", "<C-h>", "<C-w>h", opts) -- focus on left
map("n", "<C-j>", "<C-w>j", opts) -- focus on down
map("n", "<C-k>", "<C-w>k", opts) -- focus on up
map("n", "<C-l>", "<C-w>l", opts) -- focus on right

-- Window resizing
-- map("n", "<A-S-l>", ":vertical resize -10<cr>", opts) -- decrease width
-- map("n", "<A-S-h>", ":vertical resize +10<cr>", opts) -- increase width
-- map("n", "<A-S-j>", ":resize -5<cr>", opts) -- decrease height
-- map("n", "<A-S-k>", ":resize +5<cr>", opts) -- increase height

map("n", "<A-S-l>", [[<cmd>lua Resize.ver("+2", 20)<CR>]], opts)
map("n", "<A-S-h>", [[<cmd>lua Resize.ver("-2", 20)<CR>]], opts)

map("n", "<A-S-j>", [[<cmd>lua Resize.hor("+1", 30)<CR>]], opts)
map("n", "<A-S-k>", [[<cmd>lua Resize.hor("-1", 30)<CR>]], opts)

map("n", "<A-S-Right>", [[<cmd>lua Resize.ver("+2", 20)<CR>]], opts)
map("n", "<A-S-Left>", [[<cmd>lua Resize.ver("-2", 20)<CR>]], opts)
map("n", "<A-S-Down>", [[<cmd>lua Resize.hor("+1", 30)<CR>]], opts)
map("n", "<A-S-Up>", [[<cmd>lua Resize.hor("-1", 30)<CR>]], opts)

-- Search highlight clear
map("n", "<S-C-n>", ":nohl<CR>", opts) -- clear search highlight

-- Select all text
-- map("n", "<C-a>", "<cmd>normal! ma ggVG`a<CR>", opts)
map("n", "<C-a>", "<cmd>SelectAll<CR>", opts)
map("i", "<C-a>", "<C-o>:SelectAll<CR>", opts)

-- Scroll(Up / Down)
vim.keymap.set("n", "<C-d>", "<cmd>ScrollDown<CR>")
vim.keymap.set("n", "<C-u>", "<cmd>ScrollUp<CR>")
vim.keymap.set("x", "<C-d>", "<cmd>ScrollDown<CR>")
vim.keymap.set("x", "<C-u>", "<cmd>ScrollUp<CR>")

-- Replace x functionality
map("n", "x", "d", opts) -- now x is equal to delete
map("v", "x", "d", opts) -- now x is equal to d in visual mode
map("n", "xx", "dd", opts) -- now xx is equal to delete line

-- Terminal tab creation
-- map("n", "<leader>tT", ":tabnew | terminal<CR>", opts) -- create new terminal tab
-- map("n", "<leader>T", ":term<CR>", opts) -- create new terminal

-- Open init.lua
map("n", "<leader>oc", function()
	vim.cmd("edit ~/.config/nvim/") -- cd init dir
	vim.cmd("edit ~/.config/nvim/init.lua") -- open init.lua
end, opts)

local function focus_next_floating_win()
	local wins = vim.api.nvim_list_wins()
	local floating_wins = {}

	for _, win in ipairs(wins) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative and config.relative ~= "" then
			table.insert(floating_wins, win)
		end
	end

	if #floating_wins == 0 then
		print("No floating windows found")
		return
	end

	local current = vim.api.nvim_get_current_win()
	local start_idx = 0

	for i, win in ipairs(floating_wins) do
		if win == current then
			start_idx = i
			break
		end
	end

	local next_idx = (start_idx % #floating_wins) + 1

	vim.api.nvim_set_current_win(floating_wins[next_idx])
end

map("n", "<Leader>bf", focus_next_floating_win, opts)

map("n", "M", function()
	vim.api.nvim_feedkeys("q", "n", false)
end, opts) -- start recording macro

map("n", "<Leader>ph", "H", opts) -- Move to the beginning of the line
map("n", "<Leader>pm", "M", opts) -- Move to the middle of the line
map("n", "<Leader>pl", "L", opts) -- Move to the end of the line

-- keymap for cmd
map("c", "<A-h>", "<Left>", noremap) -- move cursor left
map("c", "<A-j>", "<Down>", noremap) -- move cursor down
map("c", "<A-k>", "<Up>", noremap) -- move cursor up
map("c", "<A-l>", "<Right>", noremap) -- move cursor right
--
map("c", "<A-0>", "<C-b>", noremap) -- move cursor to the beginning of the line
map("c", "<A-4>", "<C-e>", noremap) -- move cursor to the end of the line
map("n", "<A-d>", "<C-e>", noremap) -- move cursor to the end of the line
--
map("c", "<A-w>", "<C-Right>", noremap) -- move cursor to the beginning of the line
map("c", "<A-e>", "<C-Right>", noremap) -- move cursor to the beginning of the line
map("c", "<A-b>", "<C-Left>", noremap) -- move cursor to the beginning of the line

-- Write File ( Save )
map("n", "<C-s>", "<cmd>write<CR>", opts) -- save current buffer
map("i", "<C-s>", "<cmd>write<CR>", opts) -- save current buffer

map("i", "<C-cr>", "<cmd>write<CR>", opts) -- save current buffer
map("n", "<C-cr>", "<cmd>write<CR>", opts) -- save current buffer

-- plus point and minus point
map("n", "=", "<C-a>", opts) -- plus point
map("n", "-", "<C-x>", opts) -- minus point

local function up_or_down_handler(up, count)
	count = count or vim.v.count
	local cur = vim.api.nvim_win_get_cursor(0)[1]
	local total = vim.api.nvim_buf_line_count(0)

	if up then
		if cur == 1 then
			vim.api.nvim_feedkeys("G", "n", false)
			return
		end
	else
		if cur == total then
			vim.api.nvim_feedkeys("gg", "n", false)
			return
		end
	end

	local key = (count > 0 and tostring(count) or "") .. (up and "k" or "j")
	local termcode = vim.api.nvim_replace_termcodes(key, true, false, true)
	vim.api.nvim_feedkeys(termcode, "n", false)
end

map("n", "k", function()
	up_or_down_handler(true)
end, opts)
map("n", "j", function()
	up_or_down_handler(false)
end, opts)

-- ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐  ┬┌─┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐
-- ├─┘│  │ ││ ┬││││└─┐  ├┴┐├┤ └┬┘│││├─┤├─┘└─┐
-- ┴  ┴─┘└─┘└─┘┴┘└┘└─┘  ┴ ┴└─┘ ┴ ┴ ┴┴ ┴┴  └─┘
-------------------------------------------------

-- Terminal toggling
-- WARN: dependence: https://github.com/akinsho/toggleterm.nvim
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts) -- toggle Terminal floating
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", opts) --  toggle Terminal horizontally
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<CR>", opts) -- toggle Terminal vertically

-- Buffer management
-- WARN : dependence: ~/.config/nvim/lua/plugins/misc/buffer_manager.lua
map("n", "<leader>bd", "<cmd>BDelete<CR>", opts) -- close current buffer
map("n", "<A-q>", "<cmd>close<CR>", opts) -- close current tabs
map("n", "<A-S-q>", "<cmd>quitall!<CR>", opts) -- force quit
map("n", "<leader>bD", "<cmd>BTrash<CR>", opts) -- delete current file
map("n", "<leader>bc", "<cmd>BCreateFile<CR>", opts) -- create new Buffer with file

-- Neotree mappings
-- WARN: dependence: https://github.com/nvim-neo-tree/neo-tree.nvim
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", opts) -- toggle neotree

-- Move lines
-- WARN: dependence: https://github.com/booperlv/nvim-gomove

-- Move letter
map("v", "<A-h>", "<Plug>GoVSMLeft", {}) -- Move letter on left
map("v", "<A-j>", "<Plug>GoVSMDown", {}) -- Move letter on down
map("v", "<A-k>", "<Plug>GoVSMUp", {}) -- Move letter on up
map("v", "<A-l>", "<Plug>GoVSMRight", {}) -- Move letter on right

-- Move line
map("n", "<A-h>", "V<Plug>GoVSMLeft<Esc>", {}) -- Move line on left
map("n", "<A-j>", "V<Plug>GoVSMDown<Esc>", {}) -- Move line on down
map("n", "<A-k>", "V<Plug>GoVSMUp<Esc>", {}) -- Move line on up
map("n", "<A-l>", "V<Plug>GoVSMRight<Esc>", {}) -- Move line on right

-- Copy (line \ letter)
map("n", "<A-S-C-h>", "<Plug>GoNSDLeft", {}) -- Copy (line \ letter) on left
map("n", "<A-S-C-j>", "<Plug>GoNSDDown", {}) -- Copy (line \ letter) on down
map("n", "<A-S-C-k>", "<Plug>GoNSDUp", {}) -- Copy (line \ letter) on up
map("n", "<A-S-C-l>", "<Plug>GoNSDRight", {}) -- Copy (line \ letter) on rigth

-- Copy select (line \ letter)
map("x", "<A-S-C-h>", "<Plug>GoVSDLeft", {}) -- Copy  select (line \ letter) on left
map("x", "<A-S-C-j>", "<Plug>GoVSDDown", {}) -- Copy  select (line \ letter) on  down
map("x", "<A-S-C-k>", "<Plug>GoVSDUp", {}) -- Copy  select (line \ letter) on up
map("x", "<A-S-C-l>", "<Plug>GoVSDRight", {}) -- Copy  select (line \ letter) on right

-- Current Path File
--WARN: dependence: ~/.config/nvim/lua/plugins/extras.current_path_file.lua
map("n", "<leader>..", "<cmd>lua require('plugins.extras.current_path_file').show_file_path()<CR>", opts)
map("n", "<leader>.y", "<cmd>lua require('plugins.extras.current_path_file').show_file_path(true)<CR>", opts)

--WARN: dependence: https://github.com/hadronized/hop.nvim
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua require'hop'.hint_words()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua require'hop'.hint_char1()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require'hop'.hint_char2()<CR>", opts)

-- Snacks Mappings
-- WARN: dependence: https://github.com/folke/snacks.nvim

-- snacks `Notify`
map("n", "<leader>nu", "<cmd>lua Snacks.notifier.hide()<CR>", opts) -- hide notify
map("n", "<leader>nh", "<cmd>lua Snacks.notifier.show_history()<CR>", opts) -- history notify
-- snacks `Telescope`
map("n", "<leader>fW", "<cmd>lua Snacks.picker.grep_word()<CR>", opts) -- search with grep
map("n", "<leader>fw", "<cmd>lua Snacks.picker.grep()<CR>", opts) -- search with grep
map("n", "<leader>fb", "<cmd>lua Snacks.picker.buffers()<CR>", opts) -- search buffers
map("n", "<leader>fr", "<cmd>lua Snacks.picker.recent()<CR>", opts) -- search recent
map("n", "<leader>fp", "<cmd>lua Snacks.picker.projects()<CR>", opts) -- search projects
map("n", "<leader>fc", "<cmd>lua Snacks.picker.colorschemes()<CR>", opts) -- theme list
map("n", "<leader>fu", "<cmd>lua Snacks.picker.undo()<CR>", opts) -- undo list
map("n", "<leader>ff", "<cmd>lua Snacks.picker.files()<CR>", opts) -- find files list
map("n", "<leader>:", "<cmd>lua Snacks.picker.commands()<CR>", opts) -- theme list
map("n", "<leader>;", "<cmd>lua Snacks.picker.command_history()<CR>", opts) -- cmdline history list
map("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<CR>", opts) -- plugin and more help
--git
map("n", "<leader>gb", "<cmd>lua Snacks.picker.git_branches()<CR>", opts) -- git branches
map("n", "<leader>gd", "<cmd>lua Snacks.picker.git_diff()<CR>", opts) -- git diff
map("n", "<leader>gl", "<cmd>lua Snacks.lazygit()<CR>", opts) -- lazy git

-- snacks `Buffer`
map("n", "<leader>br", "<cmd>lua Snacks.rename.rename_file()<CR>", opts) -- rename current file

-- snacks `Dashboard`
map("n", "<leader>dd", "<cmd>lua Snacks.dashboard()<CR>", opts) -- open Dashboard

-- -- snacks  `Terminal`
-- map("n", "<C-t>", "<cmd>lua Snacks.terminal.toggle()<CR>", opts) -- open Dashboard

-- Yazi file manager
-- WARN: dependence: https://github.com/floke/yazi
map("n", "<A-e>", "<cmd>Yazi cwd<CR>", opts)
-- Mason
--WARN: dependence https://github.com/williamboman/mason.nvim
map("n", "<leader>lm", "<cmd>Mason<CR>", opts)

-- Bufferline
--WARN: dependence https://github.com/akinsho/bufferline.nvim
map("n", "<A-p>", "<cmd>BufferLineTogglePin<CR>") -- pinning buffer
map("n", "<A-S-P>", "<cmd>BufferLinePick<CR>") -- go to pick buffer
map("n", "<A-S-D>", "<cmd>BufferLinePickClose<CR>") -- go to pick buffer

map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>") -- go to <int> buffer
map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>") -- go to <int> buffer
map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>") -- go to <int> buffer
map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>") -- go to <int> buffer
map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>") -- go to <int> buffer
map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>") -- go to <int> buffer
map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>") -- go to <int> buffer
map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>") -- go to <int> buffer
map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>") -- go to <int> buffer

-- next or previous buffer
map("n", "<S-j>", "<cmd>BufferLineCycleNext<CR>", opts) -- cycle through buffers next
map("n", "<S-k>", "<cmd>BufferLineCyclePrev<CR>", opts) -- cycle through buffers previous

-- ccc Color picker and converter
-- WARN: dependence: https://github.com/uga-rosa/ccc.nvim
map("n", "<leader>cp", "<cmd>CccPick<CR>", opts) -- color picker
map("n", "<leader>cc", "<cmd>CccConvert<CR>", opts) -- color picker
