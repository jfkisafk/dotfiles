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

        map("n", "<leader>gP", gs.preview_hunk, "Preview hunk")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
      end,
    },
  },
  {
    "FabijanZulj/blame.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gb", "<cmd>BlameToggle window<cr>", desc = "Git Blame (Window)" },
    },
    config = function()
      local p = require("rose-pine.palette")

      require("blame").setup({
        date_format = "%Y-%m-%d %H:%M",
        views = {
          window = {
            width = 50,
            height = 20,
          },
        },
        merge_consecutive = false,
        max_summary_width = 30,
        colors = { p.love, p.gold, p.rose, p.pine, p.foam, p.iris },
      })
    end,
  },
}
