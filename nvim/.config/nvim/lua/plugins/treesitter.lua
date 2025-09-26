-- treesitter plugin config

return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"rust",
					"markdown",
					"markdown_inline",
					"html",
					-- "latex",
					"yaml",
					"typst",
					"forth",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
		-- event = { "BufReadPost", "BufNewFile" },
		main = "nvim-treesitter.configs",
		opts = {
			disable = { "latex" },
		},
		-- dev = true,
		-- opts = {
		-- 	-- autotag = {
		-- 	--	 enable = true
		-- 	-- },
		-- 	highlight = {
		-- 		-- `false` will disable the whole extension
		-- 		enable = true,
		-- 		additional_vim_regex_highlighting = true,
		-- 	},
		-- 	incremental_selection = {
		-- 		enable = true,
		-- 		keymaps = {
		-- 			init_selection = "<CR>",
		-- 			node_incremental = "<CR>",
		-- 			scope_incremental = "<S-CR>",
		-- 			node_decremental = "<BS>",
		-- 		},
		-- 	},
		-- }
	}
}
