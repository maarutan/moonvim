-- ┬  ┌─┐┌─┐  ┬┌─┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐
-- │  └─┐├─┘  ├┴┐├┤ └┬┘│││├─┤├─┘└─┐
-- ┴─┘└─┘┴    ┴ ┴└─┘ ┴ ┴ ┴┴ ┴┴  └─┘
-- Copyright (c) 2025 maarutan. \ Marat Arzymatov  All Rights Reserved.
-------------------------------------------------------------------------
---@diagnostic disable: undefined-global
local lspconfig = require("lspconfig")

local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	buf_set_keymap("n", "<leader>ld", "<cmd>Lspsaga goto_definition<CR>", opts)
	buf_set_keymap("n", "<leader>lD", "<cmd>Lspsaga goto_type_definition<CR>", opts)
	buf_set_keymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>lh", "<cmd>Lspsaga hover_doc<CR>", opts)
	buf_set_keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
	buf_set_keymap("n", "<leader>lo", "<cmd>Lspsaga outline<CR>", opts)
	buf_set_keymap("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
	buf_set_keymap("n", "<leader>dw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
	buf_set_keymap("n", "<leader>dc", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	buf_set_keymap("n", "<leader>dl", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	buf_set_keymap("n", "<leader>dh", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	buf_set_keymap("n", "<leader>lR", "<cmd>LspRestart<CR>", opts)
	buf_set_keymap("n", "<leader>lI", "<cmd>LspInfo<CR>", opts)
	buf_set_keymap("n", "<leader>lS", "<cmd>LspStop<CR>", opts)
	buf_set_keymap("n", "<leader>ls", "<cmd>LspStart<CR>", opts)
end

-- Setup language servers
local servers = {
	"ts_ls",
	"pyright",
	"bashls",
	"cssls",
	"html",
	"lua_ls",
	"jsonls",
	"marksman",
	"sqls",
	"taplo",
	"yamlls",
	"clangd",
	"hyprls",
	"nil_ls",
	"rust_analyzer",
}
for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = on_attach,
	})
end
