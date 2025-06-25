local prettierd = require("plugins.dev.formatters.modules.prettierd")
local prettier = require("plugins.dev.formatters.modules.prettier")
local ruff = require("plugins.dev.formatters.modules.ruff")
local stylua = require("plugins.dev.formatters.modules.stylua")
local beautysh = require("plugins.dev.formatters.modules.beautysh")
local black = require("plugins.dev.formatters.modules.black")
local djlint = require("plugins.dev.formatters.modules.djlint")
local clang_format = require("plugins.dev.formatters.modules.clang_format")
local alejandra = require("plugins.dev.formatters.modules.alejandra")
local rustfmt = require("plugins.dev.formatters.modules.rustfmt")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

require("formatter").setup({
	filetype = {
		---------------
		-- prettierd --
		---------------
		javascript = { prettierd.format },
		typescript = { prettierd.format },
		typescriptreact = { prettierd.format },
		javascriptreact = { prettierd.format },
		html = { prettierd.format },
		css = { prettierd.format },
		json = { prettierd.format },
		markdown = { prettierd.format },

		---------------
		-- prettier --
		---------------
		-- javascript = { prettierd.format },
		-- typescript = { prettierd.format },
		-- typescriptreact = { prettierd.format },
		-- javascriptreact = { prettierd.format },
		-- html = { prettierd.format },
		-- css = { prettierd.format },
		-- json = { prettierd.format },
		-- markdown = { prettierd.format },

		----------
		-- ruff --
		----------
		python = { ruff.format },

		-----------
		-- black --
		-----------
		-- python = { black.format },

		------------
		-- stylua --
		------------
		lua = { stylua.format },

		--------------
		-- beautysh --
		--------------
		sh = { beautysh.format },
		bash = { beautysh.format },
		zsh = { beautysh.format },

		------------
		-- djinja --
		------------
		-- html = { djlint.format },
		django = { djlint.format },

		------------
		-- c, c++ --
		------------
		c = { clang_format.format },
		cpp = { clang_format.format },

		----------
		-- nix --
		----------
		nix = { alejandra.format },

		----------
		-- rust --
		----------
		rust = { rustfmt.format },
	},
})

----------------------------
------ format on save ------
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
----------------------------
