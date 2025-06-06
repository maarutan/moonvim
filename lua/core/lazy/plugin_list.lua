return {
	{ "catppuccin/nvim" }, -- colorscheme
	{ "shaunsingh/nord.nvim" }, -- colorscheme
	{ "Tsuzat/NeoSolarized.nvim" }, -- colorscheme
	{ "kvrohit/substrata.nvim" }, -- colorscheme
	{ "katawful/kat.nvim" }, -- colorscheme
	{ "craftzdog/solarized-osaka.nvim" }, -- colorscheme
	{ "maxmx03/solarized.nvim" }, -- colorscheme
	{ "projekt0n/github-nvim-theme" }, -- colorscheme
	{ "EdenEast/nightfox.nvim" }, -- colorscheme,
	{ "nyoom-engineering/oxocarbon.nvim" }, -- colorscheme,
	{ "rose-pine/neovim" }, -- colorscheme,
	{ "Koalhack/koalight.nvim" }, -- colorscheme
	{ "marko-cerovac/material.nvim" }, -- colorscheme
	{ "ellisonleao/gruvbox.nvim" }, -- colorscheme
	{ "folke/tokyonight.nvim" }, -- colorscheme
	{ "rebelot/kanagawa.nvim" }, -- colorscheme
	{ "mofiqul/vscode.nvim" }, -- colorscheme
	{ "sainnhe/everforest" }, -- colorscheme
	{ "scottmckendry/cyberdream.nvim" }, -- colorscheme
	{ "binhtran432k/dracula.nvim" }, -- colorscheme
	{ "shaunsingh/moonlight.nvim" }, -- colorscheme
	{ "akinsho/toggleterm.nvim" }, -- toggle terminal
	{ "nvim-neo-tree/neo-tree.nvim" }, -- file explorer
	{ "nvim-lua/plenary.nvim" }, --  Lua utils for Neovim
	{ "nvim-tree/nvim-web-devicons" }, -- Provides file type icons for Neovim plugins like nvim-tree, enhancing visual navigation.
	{ "MunifTanjim/nui.nvim" }, -- Neovim User Interface (UI) Framework
	{ "booperlv/nvim-gomove" }, -- ( move \ copy ) lines, letters
	{ "hadronized/hop.nvim" }, -- Fast and efficient symbol/word jumping for improved navigation in Neovim.
	{ "folke/todo-comments.nvim" }, -- INFO: Highlight and manage `TODO` comments in Neovim.
	{ "nvim-telescope/telescope.nvim" }, -- Fuzzy finder and picker for Neovim.
	{ "nvim-telescope/telescope-file-browser.nvim" }, -- File browser extension for Telescope.
	{ "rcarriga/nvim-notify" }, -- Fancy notification manager for Neovim.
	{ "maarutan/nvim-nocut" }, -- uncut on removal.
	{ "maarutan/nvim-visual-multi", branch = "main" }, -- Multiple cursors support for Neovim.
	{ "kylechui/nvim-surround", opts = {} }, -- Add, change, and delete surroundings in Neovim.
	{ "maarutan/splitResizer.nvim" }, -- Dynamic split resizing
	{ "raddari/last-color.nvim" }, -- Save Last colorscheme
	{ "nvim-lualine/lualine.nvim" }, -- Bottom status bar for Neovim.
	{ "folke/noice.nvim" }, -- Strong change ui Neovim
	{ "lukas-reineke/indent-blankline.nvim" }, -- indent line back line
	{ "echasnovski/mini.indentscope" }, -- indent line back line anims
	{ "echasnovski/mini.comment" }, -- nvim comments
	-- { "glepnir/dashboard-nvim" }, -- welcome screen in nvim
	{ "folke/snacks.nvim" }, -- selection of improved plugins
	{ "akinsho/toggleterm.nvim" }, -- toggle terminal
	{ "mikavilpas/yazi.nvim", opts = {} }, -- yazi for nvim
	{ "mikesmithgh/kitty-scrollback.nvim" }, -- kitty edit line mode
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" }, -- wrap unwrap text
	{ "windwp/nvim-autopairs" }, -- autopairs it's you write: `"` - autopairs: `""`
	{ "folke/which-key.nvim", event = "VeryLazy" }, -- preview binding keys
	{ "nvim-treesitter/nvim-treesitter" }, -- highlighting sintax prog lang
	{ "nvim-treesitter/nvim-treesitter-context" }, -- context: watch where you go
	{ "dstein64/nvim-scrollview" }, -- scroll for nvim
	{ require("plugins.dev.database.dadbod") }, -- ide for data base sql and more
	{ "RRethy/vim-illuminate" }, -- for hightlighting double words
	{ "echasnovski/mini.icons", version = "*" }, -- mini icons pack
	{ "mhartington/formatter.nvim" }, -- formatting for nvim
	{ "williamboman/mason.nvim" }, -- lsp, formatter, linter launcher
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" }, -- auto installer
	{ "andymass/vim-matchup", opts = {} }, -- hightlighting for lsp related things
	{ "jinh0/eyeliner.nvim" }, --  hightlighting for func `f`, `F` chars
	{ "lewis6991/gitsigns.nvim" }, -- git hightlighting help previews
	{ "akinsho/bufferline.nvim" }, -- preview buffer lines
	{ "nvimdev/lspsaga.nvim" }, -- more opportunities for lsp
	{ "neovim/nvim-lspconfig" }, -- lsp supprot for nvim
	{ "hrsh7th/nvim-cmp" }, -- cmp for nvim
	{ "hrsh7th/cmp-nvim-lua" }, -- cmp for nvim
	{ "hrsh7th/cmp-calc" }, -- cmp for nvim
	{ "hrsh7th/cmp-nvim-lsp" }, -- cmp for nvim
	{ "hrsh7th/cmp-buffer" }, -- cmp for nvim
	{ "hrsh7th/cmp-path" }, -- cmp for nvim
	{ "hrsh7th/cmp-cmdline" }, -- cmp for nvim
	{ "saadparwaiz1/cmp_luasnip" }, -- cmp for nvim
	{ "onsails/lspkind-nvim" }, -- cmp for nvim
	{ "L3MON4D3/LuaSnip" }, -- support snipent for nvim
	{ "Exafunction/codeium.nvim" }, -- ai complite for nvim `codeium`
	{ "zbirenbaum/copilot.lua" }, -- `copilot` for nvim
	{ "zbirenbaum/copilot-cmp" }, -- `copilot` for nvim
	{ "CopilotC-Nvim/CopilotChat.nvim" }, -- `copilot` chat for nvim
	{ "AndreM222/copilot-lualine" }, -- `copilot` lualine for nvim
	{ "wakatime/vim-wakatime" }, -- wakatime for monitoring time
	{ "windwp/nvim-ts-autotag" },
	{ "uga-rosa/ccc.nvim" },
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" }, -- snippets from vscode for nvim
	{ "jackMort/ChatGPT.nvim" }, -- ai chatgpt for nvim
	{ "folke/trouble.nvim" }, -- optional
	{ "barrett-ruth/live-server.nvim", build = "pnpm add -g live-server" }, -- live server for html
	{ "maarutan/coderunner.nvim" }, -- run code in nvim
	{ "azratul/live-share.nvim", dependencies = "jbyuki/instant.nvim" }, -- live share for nvim
	{ "brenoprata10/nvim-highlight-colors" }, -- highlighting colors
	-- { "pocco81/auto-save.nvim" }, -- auto save like vscode
	{ "fei6409/log-highlight.nvim" }, -- highlighting log files
	-- { "karb94/neoscroll.nvim" }, -- smooth scroll for neovim
	{ "echasnovski/mini.animate" }, -- animation for nvim
	{ "stevearc/dressing.nvim" }, -- enter ui for nvim
	{ "lambdalisue/vim-suda" }, -- sudo
	{ require("plugins.ui.nekifoch") }, -- neki for nvim only for (KITTY terminal)
	{ "maarutan/macro-notify.nvim", opts = {} },
}
