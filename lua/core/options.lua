-- ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
-- │ │├─┘ │ ││ ││││└─┐
-- └─┘┴   ┴ ┴└─┘┘└┘└─┘
-- Copyright (c) 2025 maarutan. \ Marat Arzymatov  All Rights Reserved.
-------------------------------------------------------------------------

-- General options --
local border = "single" -- "rounded" | "single" | "double"  | "none"
vim.loader.enable() -- fast loader.
vim.opt.syntax = "off" -- Disable syntax highlighting
vim.opt.mouse = "" -- Mouse options.
vim.opt.number = true -- Set numbers.
vim.opt.termguicolors = true
vim.opt.relativenumber = true -- Set relativenumber.
vim.opt.expandtab = true --  `Tab` will be converted to spaces.
vim.opt.tabstop = 2 -- Number of spaces a `tab` character displays as (visual width).
vim.opt.shiftwidth = 2 -- Number of spaces for each level of indentation (auto-indent step).
vim.opt.autoread = true -- Automatically read the file if it was modified outside of Vim.
vim.opt.cursorline = true -- Highlight the current line where the cursor is positioned.

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard for all copy/paste operations

-- Neo Chars
vim.opt.list = true -- Display invisible characters like tabs, spaces, and end-of-line characters.
vim.opt.foldenable = true -- Disable folding of code blocks, so everything stays visible

-- Customize characters representing invisible characters in the text
vim.opt.listchars = {
	tab = "│ ", -- Display tabs as a vertical bar with a space after it.
	trail = "→", -- Show trailing spaces as an arrow symbol.
	-- eol = "↴",      -- Uncomment to show end-of-line characters as a downward arrow.
	extends = "󰜵", -- Show overflowed characters (horizontal scroll) as a special symbol.
	precedes = "󰜲", -- Show preceeding overflowed characters as a special symbol.
}

-- Customize characters used in various parts of the UI
vim.opt.fillchars = {
	fold = " ", -- Character used to represent folded lines (empty space).
	foldopen = "", -- Character used to represent an open fold (Nerd Font symbol).
	foldsep = " ", -- Character separating folds (empty space).
	eob = " ", -- Character used at the end of the buffer (empty space).
	foldclose = "", -- Character used to represent a closed fold (Nerd Font symbol).
}

-- Search settings --
vim.opt.inccommand = "split" -- Show the effects of a substitution (e.g., :s) in a split window as you type the command.
vim.opt.ignorecase = true -- Ignore case when searching (case-insensitive search).
vim.opt.smartcase = true -- If the search query contains uppercase letters, the search becomes case-sensitive.
vim.opt.hlsearch = true -- Enable highlighting of search matches. Use :nohlsearch to disable.
vim.opt.incsearch = true -- Enable incremental search, results update as you type the search query.

-- Disable auto comment
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*", -- This will apply to all files
	callback = function()
		vim.opt.formatoptions:remove("c") -- Removes 'c' formatting option (automatic insertion of comments)
		vim.opt.formatoptions:remove("r") -- Removes the 'r' formatting option (automatic line break when typing)
		vim.opt.formatoptions:remove("o") -- Removes the 'o' formatting option (automatic line continuation after 'o' or 'O')
	end,
})

-- Interface settings
vim.opt.termguicolors = true -- Enable true color support for better visual experience
vim.opt.signcolumn = "yes" -- Always show the sign column, even if not used
vim.opt.wrap = false -- Disable line wrapping, so long lines will scroll horizontally
vim.opt.textwidth = 0 -- Disable automatic text wrapping, text will continue on one line

-- Windows and splits settings
vim.opt.splitright = true -- When using :vsplit, open new windows to the right of the current one
vim.opt.splitbelow = true -- When using :split, open new windows below the current one

-- Performance settings
vim.opt.updatetime = 100 -- Faster updates for responsiveness, but may increase resource usage
vim.opt.timeoutlen = 500 -- Adjust how quickly vim processes key combinations

-- Scrolling settings
vim.opt.scrolloff = 4 -- Keep int lines visible above and below the cursor when scrolling vertically
vim.opt.sidescrolloff = 4 -- Keep int columns visible to the left and right of the cursor when scrolling horizontally

-- File handling settings
vim.opt.swapfile = false -- Disable swap files (no temporary swap files will be created)
vim.opt.backup = false -- Disable backup files (no backup copies will be made)
vim.opt.undofile = true -- Enable undo files (history of changes will be saved for recovery)

-- Set directory for undo files (create it if it doesn't exist)
local undodir = vim.fn.stdpath("data") .. "/undo"
if not vim.fn.isdirectory(undodir) then
	vim.fn.mkdir(undodir, "p") -- Create the directory for undo files
end
vim.opt.undodir = undodir -- Set the directory for undo files

vim.cmd([[cabbrev Q q]])
vim.cmd([[cabbrev W w]])

return {
	border = border,
}
