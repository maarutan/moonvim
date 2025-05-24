local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")

local border = require("core.options").border
local custom_menu_icon = {
	codeium = "󰘦",
	copilot = "",
	calc = "󰃬",
}

---@param up boolean
local function smoothScrollCmd(up)
	local max_scroll = 4
	local counter = 0
	local timer = vim.loop.new_timer()
	timer:start(
		0,
		30,
		vim.schedule_wrap(function()
			counter = counter + 1
			local ok
			if up then
				ok = cmp.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 1 })
			else
				ok = cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 1 })
			end
			if not ok then
				timer:stop()
				return
			end
			if counter == max_scroll then
				timer:stop()
			end
		end)
	)
end

cmp.setup({
	-- ui
	window = {

		completion = {

			border = border,
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
			col_offset = 4,
		},
		documentation = {
			border = border,
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
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
			else
				fallback()
			end
		end, { "i", "c" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
			else
				fallback()
			end
		end, { "i", "c" }),
		["<C-e>"] = cmp.mapping.close(),

		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

		["<C-d>"] = cmp.mapping(function()
			smoothScrollCmd(true)
		end, { "i", "c" }),

		["<C-u>"] = cmp.mapping(function()
			smoothScrollCmd(false)
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
		{ name = "nvim_lua" },
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
			local lspkind_fmt = require("lspkind").cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
			})(entry, vim_item)

			local strings = vim.split(lspkind_fmt.kind, "%s", { trimempty = true })

			if custom_menu_icon[entry.source.name] then
				lspkind_fmt.kind = " " .. custom_menu_icon[entry.source.name] .. " "
			else
				lspkind_fmt.kind = " " .. (strings[1] or "") .. " "
			end

			local menu_label = strings[2] or entry.source.name or ""
			if menu_label ~= "" then
				menu_label = menu_label:sub(1, 1):upper() .. menu_label:sub(2)
			end
			lspkind_fmt.menu = "   [ " .. menu_label .. " ]"

			local color_item = require("nvim-highlight-colors").format(entry, { kind = vim_item.kind })
			if color_item.abbr_hl_group then
				lspkind_fmt.kind_hl_group = color_item.abbr_hl_group
				lspkind_fmt.kind = color_item.abbr
			end

			return lspkind_fmt
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
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
				else
					fallback()
				end
			end, { "i", "c" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
				else
					fallback()
				end
			end, { "i", "c" }),

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
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
				else
					fallback()
				end
			end, { "i", "c" }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
				else
					fallback()
				end
			end, { "i", "c" }),
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
