-- Customize characters representing invisible characters in the text
local char = "|" --
local blacklist = {
	"snacks_dashboard",
	"snacks",
	"dashboard",
	"help",
	"neo-tree",
	"lazy",
	"terminal",
	"toggleterm",
	"term",
}
vim.opt.listchars = {
	tab = char .. " ", -- Display tabs as a vertical bar with a space after it.
	trail = "→", -- Show trailing spaces as an arrow symbol.
	-- eol = "↴",      -- Uncomment to show end-of-line characters as a downward arrow.
	extends = "󰜵", -- Show overflowed characters (horizontal scroll) as a special symbol.
	precedes = "󰜲", -- Show preceeding overflowed characters as a special symbol.
}

require("ibl").setup({
	indent = {
		char = char,
	},
	scope = {
		enabled = false,
	},
	exclude = {
		filetypes = blacklist,
	},
})

require("mini.indentscope").setup({
	draw = {
		delay = 100,
		animation = require("mini.indentscope").gen_animation.linear({
			easing = "in-out",
			duration = 25,
			unit = "step",
		}),

		priority = 2,
	},

	options = {
		border = "both",
		indent_at_cursor = true,
		try_as_border = false,
	},

	symbol = char,

	vim.api.nvim_create_autocmd("FileType", {
		pattern = blacklist,
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	}),
})
