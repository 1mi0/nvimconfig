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

vim.cmd[[colorscheme jellybeans |
					\ highlight SpecialKey ctermfg=white guifg=white |
					\ highlight Mi0LspError ctermbg=red guibg=#FF4136 ctermfg=white guifg=white |
					\ highlight Mi0LspWarning ctermbg=yellow guibg=#FF851B ctermfg=black guifg=black |
					\ highlight Mi0LspInformation ctermbg=blue guibg=#0074D9 ctermfg=white guifg=white |
					\ highlight Mi0LspHint ctermbg=blue guibg=#0074D9 ctermfg=black guifg=black]]
