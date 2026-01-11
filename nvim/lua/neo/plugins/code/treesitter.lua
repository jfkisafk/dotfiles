return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'FileType' },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('myconfig.treesitter', { clear = true }),
        pattern = { '*' },
        callback = function(event)
          local filetype = event.match
          local lang = vim.treesitter.language.get_lang(filetype)
          if not lang then
            return
          end

          local is_installed, _ = vim.treesitter.language.add(lang)

          if not is_installed then
            local available_langs = require('nvim-treesitter').get_available()
            if vim.tbl_contains(available_langs, lang) then
              vim.notify('Parser available for ' .. lang .. '. Please add to install func', vim.log.levels.INFO)
            end
            return
          end

          if not pcall(vim.treesitter.start, event.buf) then
            return
          end

          vim.api.nvim_create_autocmd("LspProgress", {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
              local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
              vim.notify(vim.lsp.status(), "info", {
                id = "lsp_progress",
                title = "LSP Progress",
                opts = function(notif)
                  notif.icon = ev.data.params.value.kind == "end" and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                end,
              })
            end,
          })
        end,
      })
    end,

    config = function()
      local ts = require('nvim-treesitter')
      ts.setup { install_dir = vim.fn.stdpath 'data' .. '/treesitter' }
      ts.install {
        'astro',
        'awk',
        'bash',
        'c_sharp',
        'comment',
        'css',
        'csv',
        'diff',
        'dockerfile',
        'editorconfig',
        'embedded_template',
        'fish',
        'git_config',
        'git_rebase',
        'gitcommit',
        'gitignore',
        'go',
        'goctl',
        'gomod',
        'gosum',
        'gotmpl',
        'gowork',
        'graphql',
        'groovy',
        'haskell',
        'hcl',
        'helm',
        'hjson',
        'html',
        'http',
        'ini',
        'java',
        'javascript',
        'jinja',
        'jinja_inline',
        'jq',
        'json',
        'json5',
        'kotlin',
        'latex',
        'lua',
        'luadoc',
        'luap',
        'make',
        'markdown',
        'markdown_inline',
        'passwd',
        'pem',
        'printf',
        'prisma',
        'proto',
        'python',
        'query',
        'regex',
        'requirements',
        'rust',
        'scala',
        'scss',
        'smithy',
        'sql',
        'ssh_config',
        'svelte',
        'terraform',
        'toml',
        'tsx',
        'typescript',
        'typst',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
        'zsh',
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'BufReadPost',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
    opts = {},
    keys = {
      { "n", "[c", function() require("treesitter-context").go_to_context(vim.v.count1) end, { silent = true }, desc = "Go up a context" }
    },
  },
  {
    'folke/ts-comments.nvim',
    event = 'BufReadPost',
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'javascript', 'jsx', 'tsx', 'markdown', 'typescript', 'xml' },
    opts = {},
  },
}
