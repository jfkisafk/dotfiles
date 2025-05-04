return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
			{
				"LiadOz/nvim-dap-repl-highlights",
				config = true,
				dependencies = {
					"mfussenegger/nvim-dap",
					"nvim-treesitter/nvim-treesitter",
				},
				build = function()
					if not require("nvim-treesitter.parsers").has_parser("dap_repl") then
						vim.cmd(":TSInstall dap_repl")
					end
				end,
			},
		},
		config = function()
			local dap = require("dap")
			local debuggers_folder = vim.fn.stdpath("data") .. "/mason"

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "󰀘 ", texthl = "DiagnosticSignError", linehl = "", numhl = "DiagnosticSignError" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "󰀘 ", texthl = "DiagnosticSignError", linehl = "", numhl = "DiagnosticSignError" }
			)
			vim.fn.sign_define(
				"DapConditionalBreakpoint",
				{ text = "󰀘 ", texthl = "DiagnosticSignHint", linehl = "", numhl = "DiagnosticSignHint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = " ", texthl = "DiagnosticSignHint", linehl = "", numhl = "DiagnosticSignHint" }
			)

			dap.adapters.coreclr = {
				type = "executable",
				command = debuggers_folder .. "/packages/netcoredbg/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			dap.adapters.netcoredbg = dap.adapters.coreclr
			dap.adapters.dotnet = dap.adapters.coreclr

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "attach - netcoredbg",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			}

			if not dap.adapters["pwa-node"] then
				dap.adapters["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						-- 💀 Make sure to update this path to point to your installation
						args = {
							debuggers_folder .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
							"${port}",
						},
					},
				}
			end
			if not dap.adapters["node"] then
				dap.adapters["node"] = function(cb, config)
					if config.type == "node" then
						config.type = "pwa-node"
					end
					local nativeAdapter = dap.adapters["pwa-node"]
					if type(nativeAdapter) == "function" then
						nativeAdapter(cb, config)
					else
						cb(nativeAdapter)
					end
				end
			end

			local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

			local vscode = require("dap.ext.vscode")
			vscode.type_to_filetypes["node"] = js_filetypes
			vscode.type_to_filetypes["pwa-node"] = js_filetypes

			for _, language in ipairs(js_filetypes) do
				if not dap.configurations[language] then
					dap.configurations[language] = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
					}
				end
			end
		end,
		keys = {
			{ "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", desc = "DAP continue" },
			{ "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>", desc = "DAP step over" },
			{ "<leader>da", "<cmd>lua require'dap'.step_into()<CR>", desc = " DAP step into" },
			{ "<leader>df", "<cmd>lua require'dap'.step_out()<CR>", desc = "DAP step out" },
			{ "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "DAP toggle breakpoint" },
			{ "<F6>", "<cmd>lua require'dap'.continue()<CR>", desc = "DAP continue" },
			{ "<F8>", "<cmd>lua require'dap'.step_over()<CR>", desc = "DAP step over" },
			{ "<F7>", "<cmd>lua require'dap'.step_into()<CR>", desc = " DAP step into" },
			{ "<F9>", "<cmd>lua require'dap'.step_out()<CR>", desc = "DAP step out" },
			{ "<F5>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "DAP toggle breakpoint" },
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui, p = require("dap"), require("dapui"), require("rose-pine.palette")

			vim.api.nvim_set_hl(0, "DapUIType", { fg = p.love })
			vim.api.nvim_set_hl(0, "DapUIVariable", { fg = p.iris })
			vim.api.nvim_set_hl(0, "DapUIValue", { fg = p.rose })

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				expand_lines = vim.fn.has("nvim-0.7"),
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
				},
			})

			dap.listeners.after.event_initialized.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		keys = {
			{ "<leader>du", ":lua require('dapui').toggle()<cr>", desc = "DAP UI toggle" },
			{
				"<leader>dw",
				":lua require('dapui').float_element('watches', { enter = true })<cr>",
				desc = "DAP UI watches",
			},
			{
				"<Leader>dx",
				":lua require('dapui').float_element('scopes', { enter = true })<cr>",
				desc = "DAP UI scopes",
			},
			{
				"<Leader>dr",
				":lua require('dapui').float_element('repl', { enter = true })<cr>",
				desc = "DAP UI REPL",
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		opts = {
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = false, -- prefix virtual text with comment string
			only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
			all_references = false, -- show virtual text on all all references of the variable (not only definitions)
			filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
			-- Experimental Features:
			virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
			all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
		},
	},
}
