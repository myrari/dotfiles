-- obsidian.nvim

return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- latest version, *not* latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
		},
	}
}
