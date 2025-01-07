return {
  "kdheepak/lazygit.nvim",
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
}
