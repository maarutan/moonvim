require("eyeliner").setup({
	highlight_on_key = true,
	max_length = 80,
	dim = true,
	highlight = {
		forward = true,
	},
})
vim.api.nvim_set_hl(0, "EyelinerPrimary", { bold = true, underline = true })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { underline = true })
