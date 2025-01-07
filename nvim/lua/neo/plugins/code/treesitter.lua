return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({
			-- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			auto_install = true,
			sync_install = true,
			-- ensure these language parsers are installed
			ensure_installed = {
				"astro",
				"bash",
				"c_sharp",
				"css",
				"diff",
				"dockerfile",
				"fish",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"go",
				"goctl",
				"graphql",
				"groovy",
				"haskell",
				"hcl",
				"hjson",
				"html",
				"http",
				"java",
				"javascript",
				"jq",
				"json",
				"json5",
				"kotlin",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"nix",
				"nu",
				"python",
				"regex",
				"rust",
				"scala",
				"scss",
				"smithy",
				"sql",
				"ssh_config",
				"svelte",
				"terraform",
				"tmux",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-a>",
					node_incremental = "<C-a>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
