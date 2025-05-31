----------------------------------------------------------------
require("plugins.colorscheme.theme.catppuccin")
require("plugins.colorscheme.theme.gruvbox")
require("plugins.colorscheme.theme.tokyonight")
require("plugins.colorscheme.theme.kanagata")
require("plugins.colorscheme.theme.vscode")
require("plugins.colorscheme.theme.everforest")
require("plugins.colorscheme.theme.dracula")
require("plugins.colorscheme.theme.rose_pine")
require("plugins.colorscheme.theme.solarized_osaka")
require("plugins.colorscheme.theme.cyberdream")

----------------------------------------------------------------

-- default theme as a backup, `recall()` can return `nil`.
local theme = require("last-color").recall() or "default"
vim.cmd.colorscheme(theme)
