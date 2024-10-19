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
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		init = function()
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			local cond = require("nvim-autopairs.conds")

			-- add spaces inside brackets
			local brackets = {
				{ '(', ')' }, { '[', ']' }, { '{', '}' }
			}
			npairs.add_rules({
				-- Rule for a pair with left-side ' ' and right side ' '
				Rule(' ', ' ')
				-- Pair will only occur if the conditional function returns true
					:with_pair(function(opts)
						-- We are checking if we are inserting a space in (), [], or {}
						local pair = opts.line:sub(opts.col - 1, opts.col)
						return vim.tbl_contains({
							brackets[1][1] .. brackets[1][2],
							brackets[2][1] .. brackets[2][2],
							brackets[3][1] .. brackets[3][2]
						}, pair)
					end)
					:with_move(cond.none())
					:with_cr(cond.none())
				-- We only want to delete the pair of spaces when the cursor is as such: ( | )
					:with_del(function(opts)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local context = opts.line:sub(col - 1, col + 2)
						return vim.tbl_contains({
							brackets[1][1] .. '  ' .. brackets[1][2],
							brackets[2][1] .. '  ' .. brackets[2][2],
							brackets[3][1] .. '  ' .. brackets[3][2]
						}, context)
					end)
			})

			-- add dollar signs for tex
			npairs.add_rules({
				Rule("$", "$", "tex")
					:with_move(function(opts)
						return opts.next_char == opts.char
					end
					)
			})
		end,
	},
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
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'diff', 'diagnostics' },
				lualine_c = { 'filename' },
				lualine_x = { 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
		},
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
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
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
				"~/dotfiles/*",
				"~/Documents/School/MATH*",
				"~/Documents/School/CS*/*",
				"~/Documents/School/LING*/*",
			},
		},
		init = function()
			-- enable saving plugin state in session
			vim.opt.sessionoptions:append("globals")
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
			{ "Shatur/neovim-session-manager" },
		},
		lazy = false,
		priority = 100,
	},
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_format_enabled = "1"
		end,
	},
	"micangl/cmp-vimtex",
	"kdheepak/cmp-latex-symbols",
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
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
	{
		"amitds1997/remote-nvim.nvim",
		version = "0.3.11",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
}
