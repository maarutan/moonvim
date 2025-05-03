-- ┌┬┐┌─┐┌─┐┌┐┌┬  ┬┬┌┬┐
-- ││││ ││ ││││└┐┌┘││││
-- ┴ ┴└─┘└─┘┘└┘ └┘ ┴┴ ┴
-- Copyright (c) 2025 maarutan. \ Marat Arzymatov  All Rights Reserved.
-------------------------------------------------------------------------
------------ core --------------
require("core.options")
require("core.keymaps")
require("core.lazy.lazy_manager")

----------- PLUGIN -------------
---- [ navigation ]
require("plugins.navigation.neo_tree")
require("plugins.navigation.hop")
-- require("plugins.navigation.telescope") -- disable because  use ( Snacks -  picker )

---- [ editing ]
require("plugins.editing.todo")
require("plugins.editing.nocut")
require("plugins.editing.multi_cursor")
require("plugins.editing.ufo")
require("plugins.editing.autopairs")
require("plugins.editing.cmp")

---- [ ai ]
-- require("plugins.ai.copilot.copilot")
-- require("plugins.ai.chatgpt.chatgpt")
require("plugins.ai.codeium.codeium")

---- [ ui ]
require("plugins.ui.split_resizer")
require("plugins.ui.lualine")
require("plugins.ui.bufferline")
require("plugins.ui.noice")
require("plugins.ui.scroll_view")
require("plugins.ui.eyeliner")
-- require("plugins.ui.notify") -- disable because use ( Snacks -  notify )
-- require("plugins.ui.indent_line") -- disable because use ( Snacks -  indent line )
-- require("plugins.ui.dashboard") -- disable because use ( Snacks -  dashboard )

---- [ extras ]
require("plugins.extras.tabs")
require("plugins.extras.whoami")
require("plugins.extras.kitty_term")

---- [ snacks ]
require("plugins.snacks.init")

---- [ mini ]
require("plugins.mini.comment")

---- [ tools ]
require("plugins.tools.toggleterm")
require("plugins.tools.coderunner")
require("plugins.tools.lspsaga")
require("plugins.tools.ts-autotag")
require("plugins.tools.ccc")
require("plugins.tools.live-server")
-- require("plugins.tools.auto-save") -- disable because i not want use it ( to turn it uncomment in `core.lazy.plugin_list` )
-- require("plugins.tools.image") -- disable because use ( Snacks -  image )

---- [ colorscheme ]
require("plugins.colorscheme.col")

---- [ dev ]
require("plugins.dev.init")
