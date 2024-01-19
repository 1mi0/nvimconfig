require('go').setup()

local mi0_lsp = require('mi0.lsp')

GoConfig = {
	Client = "gopls",
}

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
function GoConfig:On_client(bufnr)
	local opts = { buffer = bufnr, remap = true }

	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
		 require('go.format').goimport()
		end,
		group = format_sync_grp,
	})

	-- GoDoc - This is really nice :)
	vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", opts)

	-- GoDebug
	vim.keymap.set("n", "<leader>dd", "<cmd>GoDebug<cr>", opts)
	vim.keymap.set("n", "<leader>ds", "<cmd>GoDbgStop<cr>", opts)
end

table.insert(mi0_lsp.Client_attached_event, GoConfig)
