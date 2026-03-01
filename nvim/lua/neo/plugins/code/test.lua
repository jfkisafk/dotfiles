return {
  "nvim-neotest/neotest",
  dependencies = {
    "nsidorenco/neotest-vstest",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vstest")({ dap_settings = { type = "coreclr", justMyCode = true } }),
      },
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>lua require'neotest'.run.run()<cr>",                       desc = "Test Nearest" },
    { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",   desc = "Test File" },
    { "<leader>td", "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", desc = "Debug Test" },
    { "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>",                    desc = "Test Stop" },
    { "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>",                  desc = "Attach Test" },
    { "<leader>to", "<cmd>Neotest output<cr>",                                       desc = "Test Output" },
    { "<leader>ty", "<cmd>Neotest summary<cr>",                                      desc = "Test Summary" },
    {
      "<leader>tw",
      "<cmd>lua require('neotest').run.run({ runCurrent = true, watch = true })<cr>",
      desc = "Watch Test",
    },
  },
}
