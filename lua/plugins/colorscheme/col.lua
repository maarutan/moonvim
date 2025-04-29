----------------------------------------------------------------
require("plugins.colorscheme.theme.catppuccin")
require("plugins.colorscheme.theme.gruvbox")
require("plugins.colorscheme.theme.tokyonight")
require("plugins.colorscheme.theme.kanagata")
require("plugins.colorscheme.theme.vscode")
require("plugins.colorscheme.theme.everforest")
require("plugins.colorscheme.theme.dracula")
----------------------------------------------------------------

-- default theme as a backup, `recall()` can return `nil`.
local theme = require("last-color").recall() or "default"
vim.cmd.colorscheme(theme)
