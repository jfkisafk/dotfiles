return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        menu = {
          border = "rounded",
          draw = {
            columns = {
              { "kind_icon" },
              { "label",    "label_description", gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = "rounded",
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/lazydev.nvim",                  opts = {} },
      { "saghen/blink.cmp" },
    },
    config = function()
      -- Get blink.cmp capabilities
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })
    end,
  },
  {
    "github/copilot.vim",
  },
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      display = {
        chat = {
          fold_context = true,
          fold_reasoning = true,
          show_reasoning = true,
          start_in_insert_mode = true,
        },
      },
      interactions = {
        chat = {
          adapter = {
            name = "claude_code",
          },
        },
        inline = {
          adapter = {
            name = "copilot",
            model = "claude-opus-4.6",
          },
        },
        cmd = {
          adapter = {
            name = "copilot",
            model = "claude-sonnet-4.6",
          },
        },
        background = {
          adapter = {
            name = "copilot",
            model = "claude-sonnet-4.6",
          },
        },
        shared = {
          keymaps = {
            always_accept = {
              callback = "keymaps.always_accept",
              modes = { n = "<F1>" },
            },
            accept_change = {
              callback = "keymaps.accept_change",
              modes = { n = "<F2>" },
            },
            reject_change = {
              callback = "keymaps.reject_change",
              modes = { n = "<F3>" },
            },
            next_hunk = {
              callback = "keymaps.next_hunk",
              modes = { n = "]h" },
            },
            previous_hunk = {
              callback = "keymaps.previous_hunk",
              modes = { n = "[h" },
            },
          },
        },
      },
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
              },
              defaults = {
                model = "opus",
              },
            })
          end,
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              defaults = {
                auth_method = "oauth-personal",
              },
            })
          end,
        },
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Code Companion Chat" },
      {
        "<leader>cv",
        "<cmd>'<,'>CodeCompanion<cr>",
        mode = { "n", "v" },
        desc = "Code Companion Inline",
      },
      { "<leader>ce", "<cmd>CodeCompanion /explain<cr>",   mode = "v",          desc = "Code Companion Explain" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-mini/mini.diff", version = "*" },
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
