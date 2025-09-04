local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

vim.keymap.set('n', '<leader>pt', function()
    builtin.grep_string({ search = "TODO" });
end)

local telescope = require('telescope')
telescope.load_extension('luasnip')
telescope.setup{
	defaults = {
		preview = false,
	},
}
