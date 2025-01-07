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

    require("lualine").setup({
      options = {
        theme = theme,
      },
      sections = {
        lualine_x = {
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
