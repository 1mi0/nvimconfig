-- Lua:
-- For dark theme (neovim's default)
vim.o.background = 'dark'

--[[
local c = require('vscode.colors').get_colors()
require('vscode').setup({
    -- Alternatively set style in setup
    -- style = 'light'

    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
				ExtraWhitespace = { fg=c.vscRed, bg=c.vscRed }
    }
})
require('vscode').load()
--]]

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "go", "cpp", "latex" },
    sync_install = false,
    auto_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

local highlights = {
	Normal = { bg="#151515", fg="#cfcf9d" },
	Cursor = { bg="#ffffff", bold=false },
	["@label"] = { fg="#ffffff", bold=false },
	["@comment"] = { fg="#86a63c", bold=false },
	["@string"] = { fg="#d67e5a", bold=false },
	["@string.escape"] = { fg="#d67e5a", bold=false },
	["@function"] = { fg="#cfcf9d", bold=false },
	["@property"] = { fg="#cfcf9d", bold=false },
	["@number"] = { fg="#de9c66", bold=false },
	["@boolean"] = { fg="#de9c66", bold=false },
	["@constant.builtin"] = { fg="#de9c66", bold=false },
	["@constant"] = { fg="#cfcf9d", bold=false },
	["@operator"] = { fg="#cfcf9d", bold=false },
	["@constructor"] = { fg="#cfcf9d", bold=false },
	["@module"] = { fg="#cfcf76", bold=false },
	["@type"] = { fg="#cfcf76", bold=false },
	["@type.colorless"] = { fg="#cfcf76", bold=false },
	["@variable"] = { fg="#cfcf9d", bold=false },
	["@variable.builtin"] = { fg="#cfcf9d", bold=false },
	["@punctuation"] = { fg="#cfcf9d", bold=false },
	["@keyword"] = { fg="#B2D1F1", bold=false },
	["@keyword.function.colorless"] = { fg="#cfcf9d", bold=false },
	["@keyword.repeat"] = { fg="#cfcf9d", bold=false },
	["@keyword.branching"] = { fg="#cfcf9d", bold=false },
	["@keyword.type"] = { fg="#cfcf9d", bold=false },
	["@keyword.declaration"] = { fg="#cfcf9d", bold=false },
	["@keyword.conditional"] = { fg="#cfcf9d", bold=false },
	["@formatting"] = { fg="#ffffff", bold=false },
	SpecialKey = { fg="white" },
	Mi0LspError = { bg="#FF4136", fg="white" },
	Mi0LspWarning = { bg="#FF851B", fg="black" },
	Mi0LspInformation = { bg="#0074D9", fg="white" },
	Mi0LspHint = { bg="#0074D9", fg="black" },
}

for groups, opts in pairs(highlights) do
		vim.api.nvim_set_hl(0, groups, opts)
end

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
	vim.highlight.on_yank()
	end,
})
