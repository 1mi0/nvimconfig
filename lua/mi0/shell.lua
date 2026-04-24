local mergeDefaults = require("mi0.defaults")

ShellUtil = {
	Running = false,
	Name = "",
	Bufnr = nil,
}

function ShellUtil:notify()
	self.buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, { "⏳ " .. self.Name .. " is running..." })

	local width = 30
	local height = 1

	local editor_width = vim.api.nvim_get_option_value("columns", {})
	local editor_height = vim.api.nvim_get_option_value("lines", {})

	local row = editor_height - height - 2 -- -2 for command line space
	local col = editor_width - width - 2   -- -2 for right padding

	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
	}

	self.win = vim.api.nvim_open_win(self.buf, false, opts)
end

function ShellUtil:dismiss()
	if self.win and vim.api.nvim_win_is_valid(self.win) then
		vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, { "✅ " .. self.Name .. " finished!" })

		vim.defer_fn(function()
			if vim.api.nvim_win_is_valid(self.win) then
				vim.api.nvim_win_close(self.win, true)
				self.win = nil
				self.buf = nil
				self.old_buffer = nil
			end
		end, 2000)
	end
end

function ShellUtil:execute(command, settings, on_done)
	if self.Running then
		vim.notify("A shell command is already running.", vim.log.levels.WARN)
		return
	end

	self.Running = true

	self.old_buffer = vim.api.nvim_get_current_buf()

	local merged = mergeDefaults({
		height = 15,
		buf = true,
		bufname = "Output",
		split = "botright split",
		name = "Command",
		notification = true,
	}, settings)

	self.Name = merged.name

	if merged.notification then
		self:notify()
	end

	if self.Bufnr and vim.api.nvim_buf_is_valid(self.Bufnr) then
		vim.api.nvim_buf_delete(self.Bufnr, { force = true })
	end

	self.Bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = self.Bufnr })

	local opened = false
	local function open()
		if opened then
			return
		end

		vim.cmd(merged.split)
		vim.api.nvim_win_set_buf(0, self.Bufnr)
		vim.api.nvim_win_set_height(0, merged.height)
		vim.api.nvim_buf_set_name(self.Bufnr, merged.bufname)
		opened = true
	end

	if merged.buf then
		open()
	end

	return vim.fn.jobstart(command, {
		stdout_buffered = false,
		stderr_buffered = false,

		on_stdout = function(_, data)
			if self.Bufnr and data then
				vim.api.nvim_buf_set_text(self.Bufnr, -1, -1, -1, -1, data)
			end
		end,

		on_stderr = function(_, data)
			if self.Bufnr then
				vim.api.nvim_buf_set_text(self.Bufnr, -1, -1, -1, -1, data)
			end
		end,

		on_exit = function(_, code)
			self:dismiss()

			if code ~= 0 then
				open()
			elseif merged.buf == false then
				vim.api.nvim_buf_delete(self.Bufnr, { force = true })
			end

			self.Running = false
			if on_done then
				local old_buffer = self.old_buffer
				on_done(old_buffer, code)
			end
		end,
	})
end

return ShellUtil
