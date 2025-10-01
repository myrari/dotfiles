-- typst preview config

return {
	{
		"chomosuke/typst-preview.nvim",
		ft = { "typst", "typ" },
		config = function()
			-- keymap for toggle preview
			vim.keymap.set("n", "<localleader>ll", ":TypstPreviewToggle<CR>")

			-- setup with config
			require("typst-preview").setup({
				follow_cursor = true,
				open_cmd = "open -a Safari %s",

				-- dependencies are installed on system, so don't install them here
				dependencies_bin = {
					["tinymist"] = nil,
					["websocat"] = nil,
				},

				-- dark mode inversions, but ignore images
				-- invert_colors = '{"image": "never", "rest": "auto"}',
			})
		end,
	}
}
