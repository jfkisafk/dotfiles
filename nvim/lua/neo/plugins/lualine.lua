return {
	"nvim-lualine/lualine.nvim",
	event = "ColorScheme",
	config = function()
		local palette = require("rose-pine.palette")
		local lazy_status = require("lazy.status")

		require("lualine").setup({
			options = {
				theme = "rose-pine",
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = palette.love },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
