return {
	{
		"https://github.com/GustavEikaas/easy-dotnet.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local dotnet = require("easy-dotnet")
			dotnet.setup({})

			-- lsp settings
			vim.lsp.config("roslyn_ls", {
				settings = {
					["csharp|formatting"] = {
						csharp_new_line_before_open_brace = "none",
						csharp_new_line_before_else = "none",
						csharp_new_line_before_catch = "none",
						csharp_new_line_before_finally = "none",
						csharp_space_after_cast = true,
						csharp_preserve_single_line_statements = false,
						csharp_preserve_single_line_blocks = false,
					},
				}
			})
		end
	}
}
