return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  opts = {},
  keys = {
    { "gp",  "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Goto Preview Definition" },
    { "gP",  "<cmd>lua require('goto-preview').close_all_win()<CR>",           desc = "Goto Preview Close" },
    { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Goto Preview References" },
    {
      "gpi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      desc = "Goto Preview Implementation",
    },
  },
}
