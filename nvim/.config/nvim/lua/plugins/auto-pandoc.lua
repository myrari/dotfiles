-- config for auto-pandoc, for editing markdown files

return {
	{
		"jghauser/auto-pandoc.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "markdown",
		init = function()
			-- toggle markdown auto-pandoc
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "*.md",
				callback = function()
					vim.keymap.set("n", "<localleader>go", function()
						if vim.g.md_pandoc_on_save then
							print("auto-pandoc: Disabled")
							vim.g.md_pandoc_on_save = false
						else
							print("auto-pandoc: Enabled")
							vim.g.md_pandoc_on_save = true
						end
					end, { silent = true, buffer = 0 })
				end,
				group = vim.api.nvim_create_augroup("setAutoPandocKeymap", {}),
				desc = "Set keymap for toggling auto-pandoc",
			})

			-- if set, run auto-pandoc on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.md",
				callback = function()
					if vim.g.md_pandoc_on_save then
						require("auto-pandoc").run_pandoc()
					end
				end,
				group = vim.api.nvim_create_augroup("setAutoPandocToggle", {}),
				desc = "Run auto-pandoc on save (if enabled)",
			})
		end,
	},
}
