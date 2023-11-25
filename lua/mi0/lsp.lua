LspConfig = {
	Client_attached_event = {}
}

function LspConfig:Call_all_events(client, opts)
	for _, curr in ipairs(self.Client_attached_event) do
		if curr.Client == client.name then
			curr:On_client(opts)
		end
	end
end

return LspConfig
