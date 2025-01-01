return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"astro",
				"bashls",
				"csharp_ls",
				"cssls",
				"docker_compose_language_service",
				"dockerls",
				"gopls",
				"gradle_ls",
				"graphql",
				"html",
				"jdtls",
				"lwc_ls",
				"jqls",
				"jsonls",
				"kotlin_language_server",
				"lemminx",
				"lua_ls",
				"marksman",
				"nil_ls",
				"pylyzer",
				"rnix",
				"rust_analyzer",
				"smithy_ls",
				"sqlls",
				"svelte",
				"tailwindcss",
				"terraformls",
				"ts_ls",
				"vacuum",
				"yamlls",
				"zls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"biome",
				"black",
				"csharpier",
				"gofumpt",
				"goimports",
				"golines",
				"google-java-format",
				"isort",
				"ktlint",
				"markdownlint",
				"mdformat",
				"prettier",
				"rustywind",
				"stylua",
				"yamlfmt",

				"gitlint",
				"hadolint",
				"ktlint",
				"markdownlint",
				"mypy",
				"pylint",
				"revive",
				"selene",
				"spectral",
				"staticcheck",
				"stylelint",
				"tfsec",
				"vacuum",
				"yamllint",
				"prettier",
				"stylua",
			},
		})
	end,
}
