return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    local sup = require("supermaven-nvim")
    local palette = require("rose-pine.palette")

    sup.setup({
      color = {
        suggestion_color = palette.muted,
        cterm = 244,
      },
    })
  end,
}
