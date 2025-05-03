local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")

local bdr = "single" -- "rounded" | "single" | "double"  | "none"
local custom_menu_icon = {
	codeium = "󰘦",
	copilot = "",
	calc = "󰃬",
}

cmp.setup({
	-- ui
	window = {

		completion = {
			border = bdr,
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			col_offset = 4,
		},
		documentation = {
			border = bdr,
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		},
	},

	mapping = {

		-- Tab / Shift-Tab: Confirm or navigate snippets
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }) -- Navigate to the next item
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump() -- Expand snippet or jump forward
			else
				fallback() -- Default behavior
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1) -- Jump backward in snippet
			else
				fallback() -- Default behavior
			end
		end, { "i", "s" }),

		["<C-Space>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.close()
			else
				cmp.complete()
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			end
		end, { "i", "c" }),
		["<C-e>"] = cmp.mapping.close(),

		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

		["<C-d>"] = cmp.mapping(function()
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 4 })
		end, { "i", "c" }),

		["<C-u>"] = cmp.mapping(function()
			cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 4 })
		end, { "i", "c" }),

		["<A-u>"] = cmp.mapping.scroll_docs(-4),
		["<A-d>"] = cmp.mapping.scroll_docs(4),

		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		["<C-l>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		["<C-Return>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
	},

	sources = cmp.config.sources({
		{
			function()
				local filetype = vim.fn.expand("%:e")
				if filetype == "html" then
					local name = "luasnip"
					return name
				end
				local name = ""
				return name
			end,
		},
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "calc" },
		{ name = "copilot" },
		{ name = "codeium" },
		{ name = "nvim_lsp" },
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	}),

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
			})(entry, vim_item)

			local strings = vim.split(kind.kind, "%s", { trimempty = true })

			if custom_menu_icon[entry.source.name] then
				kind.kind = " " .. custom_menu_icon[entry.source.name] .. " "
			else
				kind.kind = " " .. (strings[1] or "") .. " "
			end

			local menu_label = strings[2] or entry.source.name or ""
			if menu_label ~= "" then
				menu_label = menu_label:sub(1, 1):upper() .. menu_label:sub(2)
			end

			kind.menu = "   [ " .. menu_label .. " ]"
			return kind
		end,
	},

	experimental = {
		ghost_text = false,
	},

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = {
			["<C-j>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "c" }),

			["<C-k>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "c" }),

			["<CR>"] = cmp.mapping.confirm({ select = true }),
		},
		sources = {
			{ name = "path" },
			{ name = "buffer" },
		},
	}),

	cmp.setup.cmdline(":", {
		mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), {
			["<C-j>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "c" }),

			["<C-k>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "c" }),

			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "cmdline" },
		}),
	}),
})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

--commands
vim.cmd([[
    cnoremap <C-j> <C-n>
    cnoremap <C-k> <C-p>
]])
