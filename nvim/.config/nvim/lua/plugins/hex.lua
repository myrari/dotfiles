-- hex view/edit plugin

return {
	{
		"RaafatTurki/hex.nvim",
		lazy = false,
		init = function()
			-- set keybinds
			vim.keymap.set("n", "<localleader>x", function()
				require("hex").toggle()
			end)
		end,
	}
}
