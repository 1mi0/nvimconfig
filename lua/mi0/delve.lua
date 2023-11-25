local mi0_lsp = require('mi0.lsp')

-- Hook the client event
LspConfig = {
	Client = "gopls"
}

function LspConfig:On_client(opts)
    vim.keymap.set("n", "<leader>dt", "<cmd>DlvToggleBreakpoint<cr>", opts)
    vim.keymap.set("n", "<leader>dr", "<cmd>DlvDebug<cr>", opts)
end

table.insert(mi0_lsp.Client_attached_event, LspConfig)
