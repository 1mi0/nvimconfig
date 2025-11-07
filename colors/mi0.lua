local colors = {
	background = "#151515",
	cursor = "#FFFFFF",
	default_fg = "#CFCF9D",
	type_fg = "#CFCF76",
	standout_white_fg = "#FFFFFF",
	standout_blue_fg = "#B2D1F1",
	comments_fg = "#86a63c",
	string_fg = "#d67e5a",
	constants_fg = "#de9c66",
};

local highlights = {
	Normal = { bg=colors.background, fg=colors.default_fg },
	Cursor = { bg=colors.standout_white_fg },
	["@label"] = { fg=colors.standout_white_fg },
	["@comment"] = { fg=colors.comments_fg },
	["@string"] = { fg=colors.string_fg },
	["@string.escape"] = { fg=colors.string_fg },
	["@function"] = { fg=colors.default_fg },
	["@property"] = { fg=colors.default_fg },
	["@number"] = { fg=colors.constants_fg },
	["@number.float"] = { fg=colors.constants_fg },
	["@tag"] = { fg=colors.default_fg },
	["@boolean"] = { fg=colors.constants_fg },
	["@constant.builtin"] = { fg=colors.constants_fg },
	["@constant"] = { fg=colors.default_fg },
	["@operator"] = { fg=colors.default_fg },
	["@constructor"] = { fg=colors.default_fg },
	["@module"] = { fg=colors.type_fg },
	["@type"] = { fg=colors.type_fg },
	["@type.builtin"] = { fg=colors.type_fg },
	["@type.colorless"] = { fg=colors.default_fg },
	["@variable"] = { fg=colors.default_fg },
	["@variable.builtin"] = { fg=colors.default_fg },
	["@punctuation"] = { fg=colors.default_fg },
	["@punctuation.delimiter.semicolon"] = { fg=colors.standout_white_fg, bold=true },
	["@punctuation.special"] = { fg=colors.standout_white_fg, bold=true },
	["@keyword.repeat"] = { fg=colors.standout_white_fg, bold=true },
	["@keyword.branching"] = { fg=colors.standout_white_fg, bold=true },
	["@keyword.conditional"] = { fg=colors.standout_white_fg, bold=true },
	["@keyword"] = { fg=colors.standout_blue_fg },
	["@keyword.return"] = { fg=colors.standout_blue_fg },
	["@keyword.function.colorless"] = { fg=colors.default_fg },
	["@keyword.type"] = { fg=colors.default_fg },
	["@keyword.declaration"] = { fg=colors.default_fg },
	["@formatting"] = { fg=colors.standout_white_fg },
	SpecialKey = { fg=colors.standout_white_fg },
	Mi0LspError = { bg="#FF4136", fg="white" },
	Mi0LspWarning = { bg="#FF851B", fg="black" },
	Mi0LspInformation = { bg="#0074D9", fg="white" },
	Mi0LspHint = { bg="#0074D9", fg="black" },
}

for groups, opts in pairs(highlights) do
	if not opts.bg then
		opts.bg = colors.background
	end

	vim.api.nvim_set_hl(0, groups, opts)
end

local lualine = {
	normal = {
		a = { bg=colors.background, fg=colors.standout_white_fg },
		b = { bg=colors.background, fg=colors.standout_white_fg },
		c = { bg=colors.background, fg=colors.standout_white_fg }
	}
}

return lualine
