-- ONEDARK THEME

return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		opts = {
			style = "darker",
		},
		init = function()
			local onedark = require("onedark")
			onedark.load()
		end
	}
}

-- local onedark = require("onedark")
-- onedark.setup({
-- 	style = "darker",
-- })
-- onedark.load()

