return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "ColorScheme",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "tabs",
			},
			highlights = require("rose-pine.plugins.bufferline"),
		})
	end,
}
