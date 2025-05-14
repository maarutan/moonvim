local wk = require("which-key")
local border = require("core.options").border

wk.setup({
	preset = "modern", --  "classic" | "modern" | "helix"
	win = {
		border = border,
	},
})

wk.add({
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", desc = "Find File" },
	{ "<leader>fW", desc = "Find Word Under Cursor" },
	{ "<leader>fu", desc = "Find Undo" },
	{ "<leader>fw", desc = "Find Word " },
	{ "<leader>fb", desc = "Find Buffer" },
	{ "<leader>fh", desc = "Find Help" },
	{ "<leader>fr", desc = "Find Recent" },
	{ "<leader>fR", desc = "Find Recent and change directory" },

	{ "<leader>g", group = "Git" },
	{ "<leader>gb", desc = "Open Branches" },
	{ "<leader>gc", desc = "Open Commits" },
	{ "<leader>gs", desc = "Open Status" },
	{ "<leader>gd", desc = "Open Diff View" },
	{ "<leader>gl", desc = "Open lazy git" },

	{ "<leader>e", desc = "Open Neotree" },
	{ "<leader>u", desc = "Undo" },
	{ "<leader>b", desc = "Buffer" },
	{ "<leader>w", desc = "Windows" },
	{ "<leader>h", desc = "hop" },
	{ "<leader>t", desc = "Terminal" },

	{ "<leader>;", desc = "cmdline History" },
	{ "<leader>:", desc = "cmdline Complete" },

	{ "<leader>n", group = "Notify" },
	{ "<leader>nu", desc = "Clear Notify" },
	{ "<leader>nh", desc = "Notify History" },

	{ "<leader>.", group = "Current `.`" },
	{ "<leader>..", desc = "Current File Path" },
	{ "<leader>.y", desc = "Current File Path Copy" },

	{ "<leader>p", group = "Postion Cursor" },
	{ "<leader>ph", desc = "High" },
	{ "<leader>pm", desc = "Middle" },
	{ "<leader>pl", desc = "Low" },

	{ "<leader>l", group = "LSP" },
	{ "<leader>ld", desc = "Declaration" },
	{ "<leader>lD", desc = "Type Definition" },
	{ "<leader>lh", desc = "Hover Doc" },
	{ "<leader>li", desc = "Implementation" },
	{ "<leader>lk", desc = "Hover" },
	{ "<leader>lI", desc = "Info" },
	{ "<leader>lR", desc = "Restart" },
	{ "<leader>lr", desc = "Rename" },
	{ "<leader>la", desc = "Code Action" },

	{ "<leader>d", group = "LSP Diagnostics" },
	{ "<leader>dh", desc = "Goto Prev Diagnostics" },
	{ "<leader>dl", desc = "Goto Next Diagnostics" },
	{ "<leader>dw", desc = "Workspace Diagnostics" },
	{ "<leader>dc", desc = "Line Diagnostics" },

	{ "<leader>D", desc = "Dashboard" },

	{ "<leader>c", group = "Comment & Colors" },
	{ "<leader>cl", desc = "Comment line" },
	{ "<leader>cc", desc = "CccConvert line" },
	{ "<leader>cp", desc = "CccPick" },

	{ "<leader>o", group = "Option" },
	{ "<leader>oc", desc = "cd init dir" },
}, { prefix = "<leader>" })
