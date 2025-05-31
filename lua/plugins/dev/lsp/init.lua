local filenames = {
	"html",
	"css",
	"typescript",
	"lua",
	"python",
	"bash",
	"c,c++",
	"json",
	"markdown",
	"sql",
	"hyprls",
	"emmet-ls",
	"nix",
	"rust",
}

for _, i in ipairs(filenames) do
	require("plugins.dev.lsp.ls_protocol." .. i)
end
