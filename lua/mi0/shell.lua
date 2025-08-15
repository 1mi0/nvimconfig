local mergeDefaults = require("mi0.defaults")

ShellUtil = {
	Running = false,
	Name = "",
	Bufnr = nil,
}

function ShellUtil:notify()
	-- Create a new buffer (scratch buffer)
    self.buf = vim.api.nvim_create_buf(false, true) -- not listed, scratch

    -- Set buffer content
    vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, { "⏳ " .. self.Name .. " is running..." })

    -- Window size
    local width = 30
    local height = 1

    -- Get editor dimensions
    local editor_width = vim.api.nvim_get_option("columns")
    local editor_height = vim.api.nvim_get_option("lines")

    -- Window position: bottom right
    local row = editor_height - height - 2  -- -2 for command line space
    local col = editor_width - width - 2    -- -2 for right padding

    -- Window options
    local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded",
    }

    -- Create the floating window
    self.win = vim.api.nvim_open_win(self.buf, false, opts)
end

function ShellUtil:dismiss()
	if self.win and vim.api.nvim_win_is_valid(self.win) then
        -- Update buffer text to finished message
        vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, { "✅ " .. self.Name .. " finished!" })

        -- Close window after a delay (e.g., 2 seconds)
        vim.defer_fn(function()
            if vim.api.nvim_win_is_valid(self.win) then
                vim.api.nvim_win_close(self.win, true)
                self.win = nil
                self.buf = nil
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

	self.Bufnr = vim.api.nvim_create_buf(false, true) -- [listed, scratch]
	vim.api.nvim_buf_set_option(self.Bufnr, "bufhidden", "wipe")

  return vim.fn.jobstart(command, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data)
      if self.Bufnr and data then
        vim.api.nvim_buf_set_lines(self.Bufnr, -1, -1, false, data)
      end
    end,

    on_stderr = function(_, data)
      if self.Bufnr and data then
        vim.api.nvim_buf_set_lines(self.Bufnr, -1, -1, false, data)
      end
    end,

    on_exit = function(_, code)
			self:dismiss()

			if merged.buf or code ~= 0 then
				vim.cmd(merged.split)
				vim.api.nvim_win_set_buf(0, self.Bufnr)
				vim.api.nvim_win_set_height(0, merged.height)
				vim.api.nvim_buf_set_name(self.Bufnr, merged.bufname)
				vim.api.nvim_buf_set_option(self.Bufnr, 'filetype', 'log')
			else
				vim.api.nvim_buf_delete(self.Bufnr, { force = true })
			end

			self.Running = false
			if on_done then
				on_done(code)
			end
    end,
	})
end

return ShellUtil
