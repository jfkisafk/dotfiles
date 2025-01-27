return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	keys = {
		{ "<leader>ee", "<Cmd>Neotree<CR>", desc = "Toggle File Explorer" },
	},
	config = function()
		local git_available = vim.fn.executable("git") == 1

		require("neo-tree").setup({
			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = { hide_gitignored = git_available },
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = vim.fn.has("win32") ~= 1,
			},
			enable_git_status = git_available,
			sources = { "filesystem", "buffers", git_available and "git_status" or nil },
			source_selector = {
				winbar = true,
				content_layout = "center",
			},
			window = {
				width = 35,
				mappings = {
					["<Space>"] = false,
					["o"] = "open",
					["<cr>"] = "open_tabnew",
					["[b"] = "prev_source",
					["]b"] = "next_source",
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<C-J>"] = "move_cursor_down",
					["<C-K>"] = "move_cursor_up",
				},
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(_)
							vim.opt_local.signcolumn = "auto"
							vim.opt_local.foldcolumn = "0"
						end,
					},
				},
			},
			filtered_items = {
				visible = true,
				hide_gitignored = false,
				hide_dotfiles = false,
				hide_hidden = false,
				hide_by_name = {
					".DS_Store",
					"node_modules",
					"target",
					"build",
					"__pycache__",
					".ipynb_checkpoints",
				},
			},
			nesting_rules = {
				["package.json"] = {
					pattern = "^package%.json$", -- <-- Lua pattern
					files = { "package-lock.json", "yarn*" }, -- <-- glob pattern
				},
				["go"] = {
					pattern = "(.*)%.go$", -- <-- Lua pattern with capture
					files = { "%1_test.go" }, -- <-- glob pattern with capture
				},
				["js-extended"] = {
					pattern = "(.+)%.js$",
					files = { "%1.js.map", "%1.min.js", "%1.d.ts" },
				},
				["docker"] = {
					pattern = "^dockerfile$",
					ignore_case = true,
					files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
				},
			},
		})
	end,
}
