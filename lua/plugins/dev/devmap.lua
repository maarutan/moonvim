local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "lh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "lc", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "le", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "l[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "l]", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "lR", "<cmd>LspRestart<CR>", opts)
	buf_set_keymap("n", "lI", "<cmd>LspRestart<CR>", opts)
end

require("lspconfig").ts_ls.setup({
	on_attach = on_attach,
})

require("lspconfig").pyright.setup({
	on_attach = on_attach,
})

require("lspconfig").bashls.setup({
	on_attach = on_attach,
})

require("lspconfig").cssls.setup({
	on_attach = on_attach,
})

require("lspconfig").html.setup({
	on_attach = on_attach,
})

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
})
