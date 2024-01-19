local mi0_lsp = require('mi0.lsp')

-- Hook the client event
DapConfig = {
	Client = "gopls"
}

--[[
require('dap-go').setup {
	dap_configurations = {
		{
			type = "go",
			name = "UdomaBackend",
      request = "launch",
      program = "/home/zestlabs/Documents/golang/backend/cmd/udoma.go",
      cwd = "/home/zestlabs/Documents/golang/backend",
		},
	},

	delve = {
		path = "dlv",
		initialize_timeout_sec = 20,
		port = "62502",
	}
}
--]]

function DapConfig:On_client(bufnr)
    local opts = { buffer = bufnr, remap = true }

    vim.keymap.set("n", "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", opts)
		vim.keymap.set("n", "<leader>n", "<cmd>DapStepOver<cr>", opts)
		vim.keymap.set("n", "<leader>c", "<cmd>DapContinue<cr>", opts)
		vim.keymap.set("n", "<leader>tr", function () require("dap-go").debug_test() end, opts)
		vim.keymap.set("n", "<leader>tl", function () require("dap-go").debug_last() end, opts)
end

table.insert(mi0_lsp.Client_attached_event, DapConfig)
