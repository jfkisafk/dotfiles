return {
  "nvim-lualine/lualine.nvim",
  event = "ColorScheme",
  config = function()
    local p = require("rose-pine.palette")
    local lazy_status = require("lazy.status")
    local theme = {
      normal = {
        a = { bg = p.rose, fg = p.base, gui = "bold" },
        b = { fg = p.rose },
        c = { fg = p.text },
      },
      insert = {
        a = { bg = p.foam, fg = p.base, gui = "bold" },
        b = { fg = p.foam },
        c = { fg = p.text },
      },
      visual = {
        a = { bg = p.iris, fg = p.base, gui = "bold" },
        b = { fg = p.iris },
        c = { fg = p.text },
      },
      replace = {
        a = { bg = p.pine, fg = p.base, gui = "bold" },
        b = { fg = p.pine },
        c = { fg = p.text },
      },
      command = {
        a = { bg = p.love, fg = p.base, gui = "bold" },
        b = { fg = p.love },
        c = { fg = p.text },
      },
      inactive = {
        a = { bg = p.base, fg = p.muted, gui = "bold" },
        b = { fg = p.muted },
        c = { fg = p.muted },
      },
    }

    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })

    require("lualine").setup({
      options = {
        theme = theme,
      },
      sections = {
        lualine_x = {
          {
            symbols.get,
            cond = symbols.has,
            color = { fg = p.love },
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = p.love },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
