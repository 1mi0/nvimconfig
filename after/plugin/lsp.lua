local lsp = require("lsp-zero")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

lsp.preset("recommended")

mason.setup({})
mason_lspconfig.setup({
	ensure_installed = {
		'lua_ls',
		'rust_analyzer',
		'gopls',
		'clangd',
		'texlab'
	},
	handlers = {
		lsp.default_setup
	}
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	mapping = {
    ['C-p'] = cmp.mapping.select_prev_item(cmp_select),
    ['C-n'] = cmp.mapping.select_next_item(cmp_select),
    ['C-y'] = cmp.mapping.confirm({ select = true }),
    ['C-Space'] = cmp.mapping.complete()
	}
})

---@diagnostic disable-next-line: unused-local
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = true }

    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", opts)
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.keymap.set("n", "<leader>vr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>vs", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>va", vim.lsp.buf.code_action, opts)
end)

local lspconfig = require('lspconfig')

-- Adds vim to the globals
local lua_opts = lsp.nvim_lua_ls()
lspconfig.lua_ls.setup(lua_opts)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
