-- ┬┌─┌─┐┬ ┬┌┐ ┬┌┐┌┌┬┐┬┌┐┌┌─┐┌─┐
-- ├┴┐├┤ └┬┘├┴┐││││ │││││││ ┬└─┐
-- ┴ ┴└─┘ ┴ └─┘┴┘└┘─┴┘┴┘└┘└─┘└─┘
-- Copyright (c) 2025 maarutan. \ Marat Arzymatov  All Rights Reserved.
-------------------------------------------------------------------------

-- Leader key
vim.g.mapleader = " " -- Set the leader key to space

local bind = vim.keymap.set -- Set keymap
local noremap = { noremap = true } -- Default options
local silent = { silent = true } -- Default options
local opts = { noremap = true, silent = true } -- Default options
-- noremap - Don't remap the keys in the mapping.
-- silent - Don't echo the key sequence in the command line.

-- betteresc
bind("i", "jk", "<Esc>", opts) -- fast escape
bind("i", "jj", "<Esc>", opts) -- fast escape

-- Buffer focus
-- Buffer - it's window workspace
bind("n", "<C-h>", "<C-w>h", opts) -- focus on left
bind("n", "<C-j>", "<C-w>j", opts) -- focus on down
bind("n", "<C-k>", "<C-w>k", opts) -- focus on up
bind("n", "<C-l>", "<C-w>l", opts) -- focus on right

-- Window resizing
bind("n", "<A-S-h>", ":vertical resize -30<cr>", opts) -- decrease width
bind("n", "<A-S-l>", ":vertical resize +30<cr>", opts) -- increase width
bind("n", "<A-S-j>", ":resize -5<cr>", opts) -- decrease height
bind("n", "<A-S-k>", ":resize +5<cr>", opts) -- increase height

bind("n", "<A-S-Right>", ":vertical resize -30<cr>", opts) -- decrease width
bind("n", "<A-S-Left>", ":vertical resize +30<cr>", opts) -- increase width
bind("n", "<A-S-Down>", ":resize -5<cr>", opts) -- decrease height
bind("n", "<A-S-Up>", ":resize +5<cr>", opts) -- increase height

-- Search highlight clear
bind("n", "<S-C-n>", ":nohl<CR>", opts) -- clear search highlight

-- Select all text
bind("n", "<C-a>", "ggVG", opts) -- select all text

-- Replace x functionality
bind("n", "x", "d", opts) -- now x is equal to delete
bind("v", "x", "d", opts) -- now x is equal to d in visual mode
bind("n", "xx", "dd", opts) -- now xx is equal to delete line

-- Terminal tab creation
bind("n", "<leader>tT", ":tabnew | terminal<CR>", opts) -- create new terminal tab
bind("n", "<leader>T", ":term<CR>", opts) -- create new terminal

-- Open init.lua
bind("n", "<leader>oc", function()
	vim.cmd("edit ~/.config/nvim/") -- cd init dir
	vim.cmd("edit ~/.config/nvim/init.lua") -- open init.lua
end, opts)

-- focus flouting buffer

bind("n", "<Leader>bf", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_set_current_win(win)
			break
		end
	end
end, opts) -- focus floating buffer

-- Macro recording toggle
bind("n", "M", "q", opts) -- start recording macro

-- Cursor positioning
bind("n", "<Leader>ph", "H", opts) -- Move to the beginning of the line
bind("n", "<Leader>pm", "M", opts) -- Move to the middle of the line
bind("n", "<Leader>pl", "L", opts) -- Move to the end of the line

-- keymap for cmd
bind("c", "<A-h>", "<Left>", noremap) -- move cursor left
bind("c", "<A-j>", "<Down>", noremap) -- move cursor down
bind("c", "<A-k>", "<Up>", noremap) -- move cursor up
bind("c", "<A-l>", "<Right>", noremap) -- move cursor right
--
bind("c", "<A-0>", "<C-b>", noremap) -- move cursor to the beginning of the line
bind("c", "<A-4>", "<C-e>", noremap) -- move cursor to the end of the line
--
bind("c", "<A-w>", "<C-Right>", noremap) -- move cursor to the beginning of the line
bind("c", "<A-e>", "<C-Right>", noremap) -- move cursor to the beginning of the line
bind("c", "<A-b>", "<C-Left>", noremap) -- move cursor to the beginning of the line

-- Write File ( Save )
bind("n", "<C-s>", "<cmd>write<CR>", opts) -- save current buffer
bind("i", "<C-s>", "<cmd>write<CR>", opts) -- save current buffer

-- plus point and minus point
bind("n", "=", "<C-a>", opts) -- plus point
bind("n", "-", "<C-x>", opts) -- minus point

-- ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐  ┬┌─┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐
-- ├─┘│  │ ││ ┬││││└─┐  ├┴┐├┤ └┬┘│││├─┤├─┘└─┐
-- ┴  ┴─┘└─┘└─┘┴┘└┘└─┘  ┴ ┴└─┘ ┴ ┴ ┴┴ ┴┴  └─┘
-------------------------------------------------

-- Terminal toggling
-- WARN: dependence: https://github.com/akinsho/toggleterm.nvim
bind("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts) -- toggle Terminal floating
bind("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts) --  toggle Terminal horizontally
bind("n", "<leader>tv", ":ToggleTerm direction=vertical size=40<CR>", opts) -- toggle Terminal vertically

-- Buffer management
-- WARN: dependence: https://github.com/famiu/bufdelete.nvim
bind("n", "<leader>bd", "<cmd>Bdelete<CR>", opts) -- close current buffer
bind("n", "<A-q>", ":close<CR>", opts) -- close current tabs
bind("n", "<A-S-q>", "<cmd>quitall!<CR>", opts) -- force quit

-- Neotree mappings
-- WARN: dependence: https://github.com/nvim-neo-tree/neo-tree.nvim
bind("n", "<leader>e", "<cmd>:Neotree toggle<CR>", opts) -- toggle neotree

-- Move lines
-- WARN: dependence: https://github.com/booperlv/nvim-gomove

-- Move letter
bind("v", "<A-h>", "<Plug>GoVSMLeft", {}) -- Move letter on left
bind("v", "<A-j>", "<Plug>GoVSMDown", {}) -- Move letter on down
bind("v", "<A-k>", "<Plug>GoVSMUp", {}) -- Move letter on up
bind("v", "<A-l>", "<Plug>GoVSMRight", {}) -- Move letter on right

-- Move line
bind("n", "<A-h>", "V<Plug>GoVSMLeft<Esc>", {}) -- Move line on left
bind("n", "<A-j>", "V<Plug>GoVSMDown<Esc>", {}) -- Move line on down
bind("n", "<A-k>", "V<Plug>GoVSMUp<Esc>", {}) -- Move line on up
bind("n", "<A-l>", "V<Plug>GoVSMRight<Esc>", {}) -- Move line on right

-- Copy (line \ letter)
bind("n", "<A-S-C-h>", "<Plug>GoNSDLeft", {}) -- Copy (line \ letter) on left
bind("n", "<A-S-C-j>", "<Plug>GoNSDDown", {}) -- Copy (line \ letter) on down
bind("n", "<A-S-C-k>", "<Plug>GoNSDUp", {}) -- Copy (line \ letter) on up
bind("n", "<A-S-C-l>", "<Plug>GoNSDRight", {}) -- Copy (line \ letter) on rigth

-- Copy select (line \ letter)
bind("x", "<A-S-C-h>", "<Plug>GoVSDLeft", {}) -- Copy  select (line \ letter) on left
bind("x", "<A-S-C-j>", "<Plug>GoVSDDown", {}) -- Copy  select (line \ letter) on  down
bind("x", "<A-S-C-k>", "<Plug>GoVSDUp", {}) -- Copy  select (line \ letter) on up
bind("x", "<A-S-C-l>", "<Plug>GoVSDRight", {}) -- Copy  select (line \ letter) on right

-- Current Path File
--WARN: dependence: ~/.config/nvim/lua/plugins/extras.current_path_file.lua
bind("n", "<leader>..", "<cmd>lua require('plugins.extras.current_path_file').show_file_path()<CR>", opts)
bind("n", "<leader>.y", "<cmd>lua require('plugins.extras.current_path_file').show_file_path(true)<CR>", opts)

--WARN: dependence: https://github.com/hadronized/hop.nvim
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua require'hop'.hint_words()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua require'hop'.hint_char1()<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require'hop'.hint_char2()<CR>", opts)

-- Snacks Mappings
-- WARN: dependence: https://github.com/folke/snacks.nvim

-- snacks `Notify`
bind("n", "<leader>nu", "<cmd>lua Snacks.notifier.hide()<CR>", opts) -- hide notify
bind("n", "<leader>nh", "<cmd>lua Snacks.notifier.show_history()<CR>", opts) -- history notify
-- snacks `Telescope`
bind("n", "<leader>fw", "<cmd>lua Snacks.picker.grep_word()<CR>", opts) -- search with grep
bind("n", "<leader>fW", "<cmd>lua Snacks.picker.grep()<CR>", opts) -- search with grep
bind("n", "<leader>fb", "<cmd>lua Snacks.picker.buffers()<CR>", opts) -- search buffers
bind("n", "<leader>fr", "<cmd>lua Snacks.picker.recent()<CR>", opts) -- search recent
bind("n", "<leader>fR", "<cmd>lua Snacks.picker.recent({cwd = vim.fn.stdpath('config')})<CR>", opts) -- search recent
bind("n", "<leader>fg", "<cmd>lua Snacks.picker.git_files()<CR>", opts) -- search git files
bind("n", "<leader>fp", "<cmd>lua Snacks.picker.projects()<CR>", opts) -- search projects
bind("n", "<leader>fc", "<cmd>lua Snacks.picker.colorschemes()<CR>", opts) -- theme list
bind("n", "<leader>fu", "<cmd>lua Snacks.picker.undo()<CR>", opts) -- undo list
bind("n", "<leader>ff", "<cmd>lua Snacks.picker.files()<CR>", opts) -- undo list
bind("n", "<leader>fF", "<cmd>lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})<CR>", opts) -- undo list
bind("n", "<leader>:", "<cmd>lua Snacks.picker.commands()<CR>", opts) -- theme list
bind("n", "<leader>;", "<cmd>lua Snacks.picker.command_history()<CR>", opts) -- theme list
bind("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<CR>", opts) -- theme list

-- Dashboard
-- WARN: dependence: https://github.com/folke/snacks.nvim
bind("n", "<leader>dd", "<cmd>lua Snacks.dashboard()<CR>", opts) -- open Dashboard

-- Yazi file manager
-- WARN: dependence: https://github.com/floke/yazi
bind("n", "<A-e>", "<cmd>Yazi cwd<CR>", opts)
-- Mason
--WARN: dependence https://github.com/williamboman/mason.nvim
bind("n", "<leader>lm", "<cmd>Mason<CR>", opts)

-- Bufferline
--WARN: dependence https://github.com/akinsho/bufferline.nvim
bind("n", "<A-p>", "<cmd>BufferLineTogglePin<CR>") -- pinning buffer
bind("n", "<A-S-P>", "<cmd>BufferLinePick<CR>") -- go to pick buffer
bind("n", "<A-S-D>", "<cmd>BufferLinePickClose<CR>") -- go to pick buffer

bind("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>") -- go to <int> buffer
bind("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>") -- go to <int> buffer
bind("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>") -- go to <int> buffer
bind("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>") -- go to <int> buffer
bind("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>") -- go to <int> buffer
bind("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>") -- go to <int> buffer
bind("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>") -- go to <int> buffer
bind("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>") -- go to <int> buffer
bind("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>") -- go to <int> buffer

-- next or previous buffer
bind("n", "<S-j>", "<cmd>BufferLineCycleNext<CR>", opts) -- cycle through buffers next
bind("n", "<S-k>", "<cmd>BufferLineCyclePrev<CR>", opts) -- cycle through buffers previous

-- ccc Color picker and converter
-- WARN: dependence: https://github.com/uga-rosa/ccc.nvim
bind("n", "<leader>cp", "<cmd>CccPick<CR>", opts) -- color picker
bind("n", "<leader>cc", "<cmd>CccConvert<CR>", opts) -- color picker
