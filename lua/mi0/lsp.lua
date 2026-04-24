LspConfig = {
	Client_attached_event = {},
	Should_restart_go_lsp = false,
}

function LspConfig:Call_all_events(client, opts)
	for _, curr in ipairs(self.Client_attached_event) do
		if curr.Client == client.name then
			curr:On_client(opts)
		end
	end
end

function LspConfig:RestartGoLsp(buffer_number)
	local clients = vim.lsp.get_clients({ name = "gopls" })
	if #clients ~= 0 then
		clients[1]:stop(true)
		self.Should_restart_go_lsp = true
		self.Buffer_number = buffer_number
	end
end

function LspConfig:GoExitEvent()
	if self.Should_restart_go_lsp then
		self.Should_restart_go_lsp = false
		vim.schedule(function()
			vim.api.nvim_buf_call(self.Buffer_number, function()
				vim.cmd("e")
			end)
		end)
	end
end

return LspConfig
