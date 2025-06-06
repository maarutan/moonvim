return {
	{
		"NeViRAIDE/nekifoch.nvim",
		build = "chmod +x ./install.sh && ./install.sh",
		cmd = "Nekifoch", -- to add lazy loading
		opts = {
			kitty_conf_path = vim.fn.expand("~/.config/kitty/kitty.conf"), -- your kitty config path
		},
	},
}
