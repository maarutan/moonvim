require("nvim_comment").setup({
	line_mapping = "<leader>cl",
	operator_mapping = "<leader>c",

	hook = function()
		local comment_strings = {
			hyprlang = "# %s",
			sql = "-- %s",
		}
		-------------------

		local ft = vim.api.nvim_buf_get_option(0, "filetype")
		if comment_strings[ft] then
			vim.api.nvim_buf_set_option(0, "commentstring", comment_strings[ft])
		end
	end,
})
