return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>st", "<cmd>Markview splitToggle<CR>", desc = "Toggle markdown preview" },
	},
}
