local border = require("core.options").border
local direction = "horizontal" -- 'vertical' | 'horizontal' | 'float'
local size = 20

if direction == "vertical" then
	size = 50
end

require("toggleterm").setup({
	open_mapping = [[<C-t>]],
	direction = direction, -- 'vertical' | 'horizontal' | 'float'
	size = size,
	float_opts = {
		border = border,
		width = 130,
		height = 27,
	},
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0, noremap = true, silent = true }

	vim.keymap.set("t", "<C-BS>", [[<C-w>]], opts)
	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "W^", [[<C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

return {
	direction = direction,
}
