return {
	-- configure rust-analyzer language server
	["rust-analyzer"] = {
		assist = {
			importGranularity = "crate",
			importEnforceGranularity = true,
		},
		cargo = {
			features = "all",
		},
		checkOnSave = true,
		check = {
			command = "clippy",
			features = "all",
			allTargets = true,
		},
		completion = {
			autoself = { enable = true },
			autoimport = { enable = true },
			postfix = { enable = true },
		},
		diagnostics = {
			enable = true,
			enableExperimental = true,
		},
		hover = {
			actions = {
				enable = true,
				run = { enable = true },
				debug = { enable = true },
				gotoTypeDef = { enable = true },
				implementations = { enable = true },
				references = { enable = true },
			},
			links = { enable = true },
			documentation = { enable = true },
		},
		imports = {
			group = { enable = true },
			merge = { glob = false },
			prefix = "self",
			preferPrelude = true,
			granularity = {
				enforce = true,
				group = "crate",
			},
		},
		inlayHints = {
			enable = true,
			bindingModeHints = { enable = true },
			chainingHints = { enable = true },
			closingBraceHints = {
				enable = true,
				minLines = 0,
			},
			closureCaptureHints = { enbale = true },
			closureReturnTypeHints = { enable = "always" },
			lifetimeElisionHints = {
				enable = "skip_trivial",
				useParameterNames = true,
			},
			typeHints = { enable = true },
			implicitDrops = { enable = true },
		},
		interpret = { tests = true },
		lens = {
			enable = true,
			run = { enable = true },
			debug = { enable = true },
			implementations = { enable = true },
			references = {
				adt = { enable = true },
				enumVariant = { enable = true },
				method = { enable = true },
				trait = { enable = true },
			},
		},
		procMacro = {
			enable = true,
			attributes = { enable = true },
		},
	},
}
