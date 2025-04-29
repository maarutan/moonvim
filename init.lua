----------
-- core --
----------
--------------------------------
require("core.options")
require("core.keymaps")
require("core.lazy.lazy_manager")
-------------
-- PLUGIN --
-------------
--------------------------------
-- navigation
require("plugins.navigation.neo_tree")
-- require("plugins.navigation.telescope")
require("plugins.navigation.hop")

-- editing
require("plugins.editing.todo")
require("plugins.editing.nocut")
require("plugins.editing.multi_cursor")
require("plugins.editing.ufo")
require("plugins.editing.autopairs")
require("plugins.editing.cmp")
require("plugins.editing.codeium")

-- ui
require("plugins.ui.split_resizer")
require("plugins.ui.lualine")
require("plugins.ui.bufferline")
require("plugins.ui.noice")
require("plugins.ui.scroll_view")
require("plugins.ui.eyeliner")
-- require("plugins.ui.notify")
-- require("plugins.ui.indent_line")
-- require("plugins.ui.dashboard")

-- extras
require("plugins.extras.tabs")
require("plugins.extras.whoami")
require("plugins.extras.kitty_term")

-- snacks
require("plugins.snacks.snacks")

-- mini
require("plugins.mini.comment")

-- tools
-- require("plugins.tools.image")
require("plugins.tools.toggleterm")
require("plugins.tools.lspsaga")

-- colorscheme
require("plugins.colorscheme.col")

-- dev
require("plugins.dev.init")
