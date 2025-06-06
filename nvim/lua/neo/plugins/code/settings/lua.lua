return {
	Lua = {
		completion = {
			callSnippet = "Replace",
		},
		runtime = {
			version = "LuaJIT",
		},
		diagnostics = {
			globals = {
				"vim",
				"require",
			},
		},
		workspace = {
			library = vim.api.nvim_get_runtime_file("", true),
		},
		telemetry = {
			enable = false,
		},
	},
}
