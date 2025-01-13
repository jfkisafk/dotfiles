return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "ColorScheme",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				mode = "tabs",
				style_preset = bufferline.style_preset.minimal,
				offsets = {
					{
						filetype = "neo-tree",
						separator = true,
					},
				},
			},
			highlights = require("rose-pine.plugins.bufferline"),
		})
	end,
}
