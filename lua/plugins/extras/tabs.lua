function main()
	--- Init `Tab` ---
	tabs__on(4, {
		"python",
		"lua",
		"bash",
		"sh",
		"zsh",
    "bash",
		"c",
		"cpp",
		"cmake",
		"haskell",
		"rust",
	})

	tabs__on(2, {
		"html",
		"css",
		"javascript",
		"tsx",
		"jsx",
		"markdown",
		"md",
		"json",
		"jsonc",
		"yaml",
		"toml",
	})
end

--- Logic `Tab`---
vim.cmd("filetype plugin indent on")
function tabs__on(tabs_on, filetypes)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetypes,
		callback = function()
			vim.opt_local.tabstop = tabs_on
			vim.opt_local.shiftwidth = tabs_on
			vim.opt_local.expandtab = true
		end,
	})
end
main()
