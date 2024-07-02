return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "c", "lua", "rust" },
				highlight = { enable = true, },
			}
		end,
	},
	"folke/neodev.nvim",
	{ 
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end
	},
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"jiangmiao/auto-pairs",
	{ 
		"navarasu/onedark.nvim", 
		lazy = true, 
		opts = {
			style = "darker",
		} 
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = '', right = ''},
    		section_separators = { left = '', right = ''},
  		  	disabled_filetypes = {
   		  		statusline = {},
      			winbar = {},
    		},
    		ignore_focus = {},
    		always_divide_middle = true,
    		globalstatus = false,
    		refresh = {
      			statusline = 1000,
      			tabline = 1000,
      			winbar = 1000,
    		}
		}
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"f-person/git-blame.nvim",
		opts = {
			enabled = true,
		}
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
	},
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/nvim-cmp",
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"coffebar/neovim-project",
		opts = {
			projects = {
				"~/projects/*",
				"~/.dotfiles/*",
				"mnt/diomonster/repo/*",
			},
		},
		init = function ()
			-- enable saving plugin state in session
			vim.opt.sessionoptions:append("globals")
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim"  },
			{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
			{ "Shatur/neovim-session-manager"  },
		},
		lazy = false,
		priority = 100,
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
	},
	{
		"lukas-reineke/virt-column.nvim",
		opts = {
			enabled = true,
			char = '|',
		},
	},
}
