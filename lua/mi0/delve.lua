local mi0_lsp = require('mi0.lsp')

-- Hook the client event
LspConfig = {
	Client = "gopls"
}

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

function LspConfig:On_client(opts)
    vim.keymap.set("n", "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", opts)
		vim.keymap.set("n", "<leader>n", "<cmd>DapStepOver<cr>", opts)
		vim.keymap.set("n", "<leader>c", "<cmd>DapContinue<cr>", opts)
    vim.keymap.set("n", "<leader>dr",
			function ()
				local widgets = require('dap.ui.widgets')
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end, opts)
		vim.keymap.set("n", "<leader>tr", function () require("dap-go").debug_test() end, opts)
		vim.keymap.set("n", "<leader>tl", function () require("dap-go").debug_last() end, opts)
		vim.keymap.set("n", "<leader>dd",
			function ()
				require("dap").continue()
			end, opts)
end

table.insert(mi0_lsp.Client_attached_event, LspConfig)
