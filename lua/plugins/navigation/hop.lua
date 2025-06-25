-- myconfig.lua (or config.lua)

require("hop").setup({
	keys = "asdfghjklwertyuiopcvbnm", -- Configure search keys, you can choose any
	hint_position = "center", -- Prompts to center the screen
	jump_on_sole_occurrence = true, -- Move at once, if one match
	case_insensitive = true, -- Ignore case
	hint_animation = true, -- Disable animation
	create_hl_autocmd = true, -- Disable auto commands for text highlighting
})

-- Hotkeys for searching
-- vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua require'hop'. hint_char1()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require'hop'.hint_char2()<CR>", { noremap = true, silent = true })
