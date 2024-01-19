-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'neomake/neomake'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

	use 'ray-x/aurora'
  use({
	  "rose-pine/neovim",
	  as = "rose-pine",
  })
  use("luisiacc/gruvbox-baby")
  use("barrientosvctor/abyss.nvim")
  use({ "kartikp10/noctis.nvim", requires = { "rktjmp/lush.nvim" } })
  use("EdenEast/nightfox.nvim")
  use ({ "projekt0n/github-nvim-theme", branch = "main" })
  use("Mofiqul/vscode.nvim")
  use("svermeulen/text-to-colorscheme")
  use({ "metalelf0/jellybeans-nvim", requires = { "rktjmp/lush.nvim" } })
  use({ "kabouzeid/nvim-jellybeans", requires = { "rktjmp/lush.nvim" } })
	use("ThePrimeagen/vim-be-good")

	use {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	}
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function ()
			require("copilot_cmp").setup()
		end
	}

  use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
  }

	use("tpope/vim-surround")

	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!:).
		run = "make install_jsregexp"
	})
  -- use('andweeb/presence.nvim')

	-- Golang and DAP
  use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'
	-- use 'theHamsta/nvim-dap-virtual-text'
	use 'ray-x/go.nvim'
	use 'ray-x/guihua.lua'

  -- Linter
	use 'mfussenegger/nvim-lint'
	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	})
	use({
		'nvim-treesitter/nvim-treesitter-textobjects',
		after = 'nvim-treesitter',
		requires = 'nvim-treesitter/nvim-treesitter'
	})
	--[[ Do not like this in conjuction with 80 character lines, function
	--   definitions take half of my screen.
	use({
		'nvim-treesitter/nvim-treesitter-context',
		after = 'nvim-treesitter',
		requires = 'nvim-treesitter/nvim-treesitter'
	})
	--]]

  use('nvim-treesitter/playground')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
	use('rbong/vim-flog')
	use('onsails/lspkind.nvim')
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'benfowler/telescope-luasnip.nvim' },
    }
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)
