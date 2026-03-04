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

    local function get_symbols()
      return symbols.get():gsub("%b()", "")
    end

    local mason_registry = require("mason-registry")
    local mason_outdated = {}

    local function mason_check()
      mason_outdated = {}
      for _, pkg in ipairs(mason_registry.get_installed_packages()) do
        if pkg.name == "csharp-language-server" then
          goto continue
        end
        local installed = pkg:get_installed_version()
        local latest = pkg:get_latest_version()
        if installed and latest and installed ~= latest then
          table.insert(mason_outdated, { name = pkg.name, version = latest })
        end
        ::continue::
      end
    end

    mason_check()
    mason_registry:on("package:install:success", vim.schedule_wrap(mason_check))

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
          {
            function()
              return "󱌣 " .. #mason_outdated
            end,
            cond = function()
              return #mason_outdated > 0
            end,
            color = { fg = p.iris },
          },
          {
            get_symbols,
            cond = symbols.has,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
