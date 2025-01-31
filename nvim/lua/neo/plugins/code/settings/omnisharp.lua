return {
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  handlers = {
    ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
    ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
    ["textDocument/references"] = require("omnisharp_extended").references_handler,
    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
  },
  keys = {
    {
      "gd",
      "lua require('omnisharp_extended').telescope_lsp_definition({ jump_type = 'vsplit' })",
      desc = "Go to definition",
    },
    {
      "gi",
      "<cmd>lua require('omnisharp_extended').telescope_lsp_implementation()<cr>",
      desc = "Go to implementation",
    },
    {
      "gt",
      "<cmd>lua require('omnisharp_extended').telescope_lsp_type_definition()<cr>",
      desc = "Go to type definition",
    },
    {
      "gR",
      "<cmd>lua require('omnisharp_extended').telescope_lsp_references()<cr>",
      desc = "Go to references",
    },
  },
}
