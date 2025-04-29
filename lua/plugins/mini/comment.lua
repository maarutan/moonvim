-- No need to copy this inside `setup()`. Will be used automatically.
require("mini.comment").setup({
	-- Options which control module behavior
	options = {
		-- Function to compute custom 'commentstring' (optional)
		custom_commentstring = nil,

		-- Whether to ignore blank lines when commenting
		ignore_blank_line = false,

		-- Whether to ignore blank lines in actions and textobject
		start_of_line = false,

		-- Whether to force single space inner padding for comment parts
		pad_comment_parts = true,
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Toggle comment (like `gcip` - comment inner paragraph) for both
		-- Normal and Visual modes
		comment = "<Leader>c",

		-- Toggle comment on current line
		comment_line = "<Leader>cl",

		-- Toggle comment on visual selection
		comment_visual = "<Leader>c",

		-- Define 'comment' textobject (like `dgc` - delete whole comment block)
		-- Works also in Visual mode if mapping differs from `comment_visual`
		textobject = "<Leader>c",
	},

	-- Hook functions to be executed at certain stage of commenting
	hooks = {
		-- Before successful commenting. Does nothing by default.
		pre = function() end,
		-- After successful commenting. Does nothing by default.
		post = function() end,
	},
})
