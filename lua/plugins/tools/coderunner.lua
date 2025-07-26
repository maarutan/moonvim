local direction = require("plugins.tools.toggleterm").direction

require("code-runner").setup({
	keymap = "<A-S-r>",
	interrupt_keymap = "<F2>",
	terminal_mode = direction, -- Default terminal mode
	commands = {
		python = "python3 -u $dir/$fileName",
		lua = "lua $dir/$fileName",
		sh = "sh $dir/$fileName",
		zsh = "zsh $dir/$fileName",
		html = "xdg-open $dir/$fileName",
	},
	extensions = {
		python = { "py" },
		lua = { "lua" },
		sh = { "sh" },
		zsh = { "zsh" },
		html = { "html" },
	},
	debug = false, -- Debug mode flag
})
