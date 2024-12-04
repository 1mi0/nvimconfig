local lsp = require("lsp-zero")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local lspconfig = require('lspconfig')

mason.setup({})
mason_lspconfig.setup({
	ensure_installed = {
		'lua_ls',
		'rust_analyzer',
		'gopls',
		'clangd',
		'texlab',
		'pylsp'
	},
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			-- Adds vim to the globals
			local lua_opts = lsp.nvim_lua_ls()
			lspconfig.lua_ls.setup(lua_opts)
		end,
		gopls = function()
			lspconfig.gopls.setup({
				settings = {
					gopls = {
						codelenses = { test = true },
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})
		end,
		clangd = function()
			lspconfig.clangd.setup({
				cmd = { "clangd-17", "--inlay-hints=true" },
			})
		end,
	}
})

local function common_keybinds(opts)
    vim.keymap.set("n", "<leader>td", "<cmd>Telescope lsp_definitions<cr>", opts)
    vim.keymap.set("n", "<leader>tr", "<cmd>Telescope lsp_references<cr>", opts)
    vim.keymap.set("n", "<leader>tD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>ti", "<cmd>Telescope lsp_implementations<cr>", opts)
    vim.keymap.set("n", "<leader>tt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
    vim.keymap.set("n", "H", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    vim.keymap.set("n", "<leader>vr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>vs", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>va", vim.lsp.buf.code_action, opts)
end

local mi0_lsp = require('mi0.lsp')

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = true }

	common_keybinds(opts)
	mi0_lsp.Call_all_events(mi0_lsp, client, bufnr)
end)

vim.diagnostic.config({
    virtual_text = true,
})
