local diagnostic_lines_ns = vim.api.nvim_create_namespace("Diagnostic Lines")
local orig_signs_handler = vim.diagnostic.handlers.signs

local function severity_highlight(severity)
	local colors = {
		{type=vim.diagnostic.severity.ERROR, colorgroup="Mi0LspError"},
		{type=vim.diagnostic.severity.WARN, colorgroup="Mi0LspWarning"},
		{type=vim.diagnostic.severity.INFO, colorgroup="Mi0LspInformation"},
		{type=vim.diagnostic.severity.HINT, colorgroup="Mi0LspHint"},
	}

	for _, color in ipairs(colors) do
		if severity == color.type then
			return color.colorgroup
		end
	end
	return 'Visual'
end

vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
        -- Handle diagnostics for whole buffer for ns convenience
        local diagnostics = vim.diagnostic.get(bufnr)
        for _, diagnostic in ipairs(diagnostics) do
			local lcount = vim.api.nvim_buf_line_count(bufnr)
			if lcount > diagnostic.lnum and diagnostic.lnum >= 0 then
				vim.api.nvim_buf_set_extmark(
					diagnostic.bufnr,
					diagnostic_lines_ns,
					diagnostic.lnum, 0,
					{ line_hl_group = severity_highlight(diagnostic.severity) }
				)
			end
        end
        orig_signs_handler.show(diagnostic_lines_ns, bufnr, diagnostics, opts)
    end,
    hide = function(_, bufnr)
        vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_lines_ns, 0, -1)
        orig_signs_handler.hide(diagnostic_lines_ns, bufnr)
    end,
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
