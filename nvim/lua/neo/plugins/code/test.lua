return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet"),
        require("neotest-jest"),
      },
      output = {
        enabled = false,
        open_on_run = false,
      },
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>lua require'neotest'.run.run()<cr>",                     desc = "Test Nearest" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test File" },
    { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Test" },
    { "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>",                  desc = "Test Stop" },
    { "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>",                desc = "Attach Test" },
    { "<leader>to", "<cmd>Neotest output<cr>",                                     desc = "Test Output" },
    { "<leader>ty", "<cmd>Neotest summary<cr>",                                    desc = "Test Summary" },
  },
}
