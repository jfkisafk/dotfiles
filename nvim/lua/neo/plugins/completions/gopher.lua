return {
  "olexsmir/gopher.nvim",
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    vim.cmd.GoInstallDeps()
  end,
  keys = {
    { "<leader>gsj", "<cmd>GoTagAdd json<CR>", desc = "Add json struct tags" },
    { "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", desc = "Add yaml struct tags" },
  },
  opts = {},
}
