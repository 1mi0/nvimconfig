require('go').setup({
	icons = false,
	dap_debug_keymap = false,
	dap_debug_gui = {
		layouts = {
			{
				-- You can change the order of elements in the sidebar
				elements = {
					-- Provide IDs as strings or tables with "id" and "size" keys
					{ id = "stacks",      size = 0.25 },
					{ id = "breakpoints", size = 0.25 },
					{
						id = "scopes",
						size = 0.5, -- Can be float or integer > 1
					},
					-- { id = "watches", size = 0.25 },
				},
				size = 40,
				position = "left", -- Can be "left" or "right"
			},
			{
				elements = {
					"repl",
					-- "console",
				},
				size = 10,
				position = "bottom", -- Can be "bottom" or "top"
			},
		},
	},
	dap_port = -1,
})

local mi0_lsp = require('mi0.lsp')
local shell = require('mi0.shell')

GoConfig = {
	Client = "gopls",
}

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
function GoConfig:On_client(bufnr)
	local opts = { buffer = bufnr, remap = true }

	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			require("go.format").goimport()
		end,
		group = format_sync_grp,
	})

	-- GoDoc - This is really nice :)
	vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", opts)

	-- GoDebug
	vim.keymap.set("n", "<leader>dd", "<cmd>GoDebug<cr>", opts)
	vim.keymap.set("n", "<leader>ds", "<cmd>GoDbgStop<cr>", opts)

	-- Generate Stuff
	vim.keymap.set("n", "<leader>gs", function()
		shell:execute(
			{ "go", "generate", "./internal/storage" },
			{
				buf = false,
				name = "Storage generation"
			},
			function(old_buffer)
				mi0_lsp:RestartGoLsp(old_buffer)
			end
		)
	end, opts)

	vim.keymap.set("n", "<leader>ga", function()
		shell:execute(
			{ "go", "generate", "./internal/api" },
			{
				height = 30,
				name = "Api generation"
			},
			function(old_buffer)
				mi0_lsp:RestartGoLsp(old_buffer)
			end
		)
	end, opts)
end

table.insert(mi0_lsp.Client_attached_event, GoConfig)
