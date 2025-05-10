return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local p = require("rose-pine.palette")

    require("octo").setup({
      default_merge_method = "squash",
      default_delete_branch = true,
      colors = {
        white = p.text,
        grey = p.subtle,
        black = p.base,
        red = p.rose,
        dark_red = p.love,
        green = p.foam,
        dark_green = p.pine,
        yellow = p.gold,
        dark_yellow = p.gold,
        blue = "#7287fd",
        dark_blue = p.love,
        purple = p.iris,
      },
    })
  end,
}
