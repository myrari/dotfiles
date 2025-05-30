return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-file-browser.nvim',
				event = "VeryLazy",
				dependencies = {
					'nvim-telescope/telescope.nvim',
					'nvim-lua/plenary.nvim',
					'nvim-tree/nvim-web-devicons'
				}
			},
		},
		keys = {
			{
				"<leader>pf",
				mode = "n",
				function() require("telescope.builtin").find_files() end,
				desc = "telescope find files"
			},
			{
				"<leader>pv",
				mode = "n",
				function() require("telescope").extensions.file_browser.file_browser() end,
				desc = "telescope file browser"
			},
			{
				"<leader>pt",
				mode = "n",
				function()
					require("telescope.builtin").treesitter()
				end,
				desc = "telescope treesitter"
			},
		},
		config = function()
			local opts = {
				extensions = {
					file_browser = {
						hidden = true,
					}
				}
			}
			require('telescope').setup(opts)
			require("telescope").load_extension "file_browser"
		end
	}
}
