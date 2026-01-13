return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")

        -- Actions
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")

        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")

        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")

        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")

        map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns blame<cr>", "Show Blame")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
      end,
    },
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>gi", "<CMD>Octo issue list<CR>",        desc = "GitHub Issues" },
      { "<leader>gp", "<CMD>Octo pr list<CR>",           desc = "GitHub Pull Requests" },
      { "<leader>gn", "<CMD>Octo notification list<CR>", desc = "GitHub Notifications" },
      { "<leader>gc", "<CMD>Octo pr create<CR>",         desc = "GitHub Create Pull Request" },
    },
    config = function()
      local p = require("rose-pine.palette")

      require("octo").setup({
        default_merge_method = "squash",
        default_delete_branch = true,
        picker = "snacks",
        colors = {
          white = p.text,
          grey = p.subtle,
          black = p.base,
          red = p.rose,
          dark_red = p.love,
          green = p.foam,
          dark_green = p.pine,
          yellow = p.gold,
          dark_yellow = p.gold,
          blue = "#7287fd",
          dark_blue = p.love,
          purple = p.iris,
        },
      })
    end,
  },
}
