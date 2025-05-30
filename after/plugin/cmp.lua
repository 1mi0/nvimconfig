local cmp = require('cmp')
local types = require('cmp.types')
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

vim.api.nvim_exec("set completeopt=menu,menuone,noselect", false)

-- LuaSnip configuration --

luasnip.config.set_config {
  history = false,
  delete_check_events = 'TextChanged',
  update_events = 'TextChanged,TextChangedI',
  region_check_events = 'CursorMoved,CursorHold,InsertEnter',
  enable_autosnippets = true,
  ext_opts = {
    [require('luasnip.util.types').choiceNode] = {
      active = {
        virt_text = { { 'o', 'Substitute' } }
      }
    }
  }
}

require("luasnip.loaders.from_vscode").load {
    include = { "go" },
		paths = { "~/.config/nvim/snippets/vscode" }
}

do
  local keymap = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  keymap('i', '<c-j>', "<cmd>lua require('luasnip').jump(1)<CR>", opts)
  keymap('s', '<c-j>', "<cmd>lua require('luasnip').jump(1)<CR>", opts)
  keymap('i', '<c-k>', "<cmd>lua require('luasnip').jump(-1)<CR>", opts)
  keymap('s', '<c-k>', "<cmd>lua require('luasnip').jump(-1)<CR>", opts)
end

-- Toggle as you type completion --

local function toggle_as_you_type()
  if require('cmp.config').get().completion.autocomplete == false then
    cmp.setup { completion = { autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged } } }
  else
    cmp.setup { completion = { autocomplete = false } }
    cmp.abort()
  end
end

vim.api.nvim_create_user_command(
  'AutocompleteToggle',
  function() toggle_as_you_type() end,
  {
    nargs = 0,
    desc = 'Toggle as-you-type completion',
  }
)
-- General setup --

cmp.setup {
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
		['C-p'] = cmp.mapping.select_prev_item(cmp_select),
		['C-n'] = cmp.mapping.select_next_item(cmp_select),
		['C-y'] = cmp.mapping.confirm({ select = true }),
		['C-Space'] = cmp.mapping.complete(),
		-- ['<CR>'] = cmp.mapping.confirm({ select = false }),
    --[[ ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expandable() then
        luasnip.expand({})
      elseif luasnip.locally_jumpable(1) and cmp.get_entries()[1] and cmp.get_entries()[1].exact then -- don't force me to tab twice when matched
        luasnip.jump(1)
      elseif cmp.get_active_entry() then
        cmp.confirm()
      elseif cmp.visible() then
        cmp.confirm { select = true }
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
		--]]

    --[[['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
		--]]
  }),
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol',
      max_width = 50,
      ellipsis_char = '...',
      menu = {
        buffer = "[buffer]",
        nvim_lsp = "[lsp]",
        luasnip = "[luasnip]",
        rails_http_status_codes = "[mine]",
        cmp_git = "[git]",
      }
    }
  },
  sources = cmp.config.sources({
    { name = "copilot", group_index = 2 },
    { name = 'luasnip', priority = 10 },
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
}

-- Custom filetypes --

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('rust', {
  sorting = {
    comparators = {
      -- Sort snippets below everything else
      function(a, b)
        local a_kind = a:get_kind()
        local b_kind = b:get_kind()
        local snippet_type = types.lsp.CompletionItemKind.Snippet

        if a_kind == snippet_type and b_kind ~= snippet_type then
          return false
        elseif a_kind ~= snippet_type and b_kind == snippet_type then
          return true
        else
          return nil
        end
      end
    }
  }
})
