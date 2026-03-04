return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    outline_window = {
      position = "right",
      width = 25,
      auto_close = true,
      show_cursorline = false,
    },
    preview_window = {
      border = "rounded",
      live = true,
    },
  },
}
