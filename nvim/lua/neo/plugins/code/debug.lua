return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

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
        command = "/run/current-system/sw/bin/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      local function find_csproj()
        local dir = vim.fn.expand("%:p:h")
        while dir and dir ~= "/" do
          local csproj = vim.fn.glob(dir .. "/*.csproj")
          if csproj ~= "" then
            return csproj:gmatch("[^\n]+")()
          end
          dir = vim.fn.fnamemodify(dir, ":h")
        end
        return nil
      end

      local function smart_pick_process()
        local utils = require("dap.utils")
        local csproj = find_csproj()
        local project = csproj and vim.fn.fnamemodify(csproj, ":t:r") or nil
        local is_build_output = function(name)
          return name:find("/bin/") ~= nil and name:find("/net%d+%.%d+/") ~= nil
        end
        local filter = project
            and function(proc)
              return proc.name:find(project, 1, true) ~= nil and is_build_output(proc.name)
            end
            or function(proc)
              return is_build_output(proc.name)
            end

        local procs = utils.get_processes({ filter = filter })
        if #procs == 1 then
          return procs[1].pid
        end

        local prompt = project and ("Attach to " .. project .. ": ") or "Select process: "
        return utils.pick_process({ filter = filter, prompt = prompt })
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "attach - netcoredbg",
          request = "attach",
          processId = smart_pick_process,
          justMyCode = false,
        },
      }
    end,
    keys = {
      { "<F6>", "<cmd>lua require'dap'.continue()<CR>",          desc = "DAP continue" },
      { "<F8>", "<cmd>lua require'dap'.step_over()<CR>",         desc = "DAP step over" },
      { "<F7>", "<cmd>lua require'dap'.step_into()<CR>",         desc = "DAP step into" },
      { "<F9>", "<cmd>lua require'dap'.step_out()<CR>",          desc = "DAP step out" },
      { "<F5>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "DAP toggle breakpoint" },
    },
  },
  {
    "igorlfs/nvim-dap-view",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local p = require("rose-pine.palette")

      -- nvim-dap-view highlight groups
      vim.api.nvim_set_hl(0, "NvimDapViewSeparator", { fg = p.highlight_med })
      vim.api.nvim_set_hl(0, "NvimDapViewBoolean", { fg = p.rose })
      vim.api.nvim_set_hl(0, "NvimDapViewConstant", { fg = p.gold })
      vim.api.nvim_set_hl(0, "NvimDapViewFloat", { fg = p.gold })
      vim.api.nvim_set_hl(0, "NvimDapViewNumber", { fg = p.gold })
      vim.api.nvim_set_hl(0, "NvimDapViewString", { fg = p.foam })
      vim.api.nvim_set_hl(0, "NvimDapViewFunction", { fg = p.iris })
      vim.api.nvim_set_hl(0, "NvimDapViewMissingData", { fg = p.love })
      vim.api.nvim_set_hl(0, "NvimDapViewWatchExpr", { fg = p.rose, bold = true })
      vim.api.nvim_set_hl(0, "NvimDapViewWatchError", { fg = p.love })
      vim.api.nvim_set_hl(0, "NvimDapViewWatchUpdated", { fg = p.gold, bg = p.highlight_low })
      vim.api.nvim_set_hl(0, "NvimDapViewFileName", { fg = p.pine })
      vim.api.nvim_set_hl(0, "NvimDapViewLineNumber", { fg = p.gold })
      vim.api.nvim_set_hl(0, "NvimDapViewFrameCurrent", { fg = p.gold, bg = p.highlight_low })
      vim.api.nvim_set_hl(0, "NvimDapViewThread", { fg = p.iris, bold = true })
      vim.api.nvim_set_hl(0, "NvimDapViewThreadStopped", { fg = p.pine })
      vim.api.nvim_set_hl(0, "NvimDapViewThreadError", { fg = p.love })
      vim.api.nvim_set_hl(0, "NvimDapViewExceptionFilterEnabled", { fg = p.foam })
      vim.api.nvim_set_hl(0, "NvimDapViewExceptionFilterDisabled", { fg = p.love })
      vim.api.nvim_set_hl(0, "NvimDapViewTab", { fg = p.subtle })
      vim.api.nvim_set_hl(0, "NvimDapViewTabSelected", { fg = p.foam })
      vim.api.nvim_set_hl(0, "NvimDapViewTabFill", { bg = p.base })
      vim.api.nvim_set_hl(0, "NvimDapViewControlNC", { fg = p.muted })
      vim.api.nvim_set_hl(0, "NvimDapViewControlPlay", { fg = p.foam })
      vim.api.nvim_set_hl(0, "NvimDapViewControlPause", { fg = p.rose })
      vim.api.nvim_set_hl(0, "NvimDapViewControlRunLast", { fg = p.iris })
      vim.api.nvim_set_hl(0, "NvimDapViewControlStepInto", { fg = p.iris })
      vim.api.nvim_set_hl(0, "NvimDapViewControlStepOver", { fg = p.iris })
      vim.api.nvim_set_hl(0, "NvimDapViewControlStepOut", { fg = p.iris })
      vim.api.nvim_set_hl(0, "NvimDapViewControlStepBack", { fg = p.iris })
      vim.api.nvim_set_hl(0, "NvimDapViewControlTerminate", { fg = p.love })
      vim.api.nvim_set_hl(0, "NvimDapViewControlDisconnect", { fg = p.love })

      require("dap-view").setup({
        winbar = {
          sections = { "scopes", "watches", "threads", "exceptions", "repl" },
          default_section = "scopes",
          show_keymap_hints = false,
          controls = {
            enabled = true,
          },
          base_sections = {
            threads = { label = "" },
            exceptions = { label = "󰈸" },
            breakpoints = { label = "󰀘 " },
            watches = { label = " " },
            scopes = { label = " " },
            repl = { label = " " },
          },
        },
        windows = {
          size = 0.3,
          position = "right",
        },
        follow_tab = true,
        auto_toggle = true,
      })
    end,
    keys = {
      { "<leader>du", "<cmd>DapViewToggle<cr>",                         desc = "DAP View toggle" },
      { "<leader>dw", "<cmd>DapViewWatch<cr>",                          desc = "DAP View add watch" },
      { "<leader>dh", "<cmd>lua require('dap.ui.widgets').hover()<cr>", desc = "DAP hover" },
    },
  },
}
