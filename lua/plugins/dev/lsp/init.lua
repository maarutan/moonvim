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
}

for _, i in ipairs(filenames) do
	require("plugins.dev.lsp.ls_protocol." .. i)
end
