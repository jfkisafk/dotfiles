return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    local sup = require("supermaven-nvim")
    local palette = require("rose-pine.palette")

    sup.setup({
      color = {
        suggestion_color = palette.pine,
      },
    })
  end,
}
