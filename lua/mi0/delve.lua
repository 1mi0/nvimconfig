local mi0_lsp = require('mi0.lsp')

-- Hook the client event
DapConfig = {
	Client = "gopls"
}

function DapConfig:On_client(bufnr)
	local opts = { buffer = bufnr, remap = true }

	vim.keymap.set("n", "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", opts)
	vim.keymap.set("n", "<leader>da", function()
		require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, opts)
	vim.keymap.set("n", "<leader>db", "<cmd>DapStepOut<cr>", opts)
	vim.keymap.set("n", "<leader>dn", "<cmd>DapStepOver<cr>", opts)
	vim.keymap.set("n", "<leader>dm", "<cmd>DapStepInto<cr>", opts)
	vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", opts)
	vim.keymap.set("n", "<leader>dd", function() require("dap-go").debug_test() end, opts)
	-- vim.keymap.set("n", "<leader>tl", function () require("dap-go").debug_last() end, opts)
end

table.insert(mi0_lsp.Client_attached_event, DapConfig)

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'WarningMsg' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🔵', texthl = 'WarningMsg' })
vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'WarningMsg' })
vim.fn.sign_define('DapStopped', { text = '➡️', texthl = 'DiagnosticInfo' })

vim.cmd("highlight DapBreakpointRejectedRed guifg=#FF0000 ctermfg=Red")
vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = 'DapBreakpointRejectedRed' })
