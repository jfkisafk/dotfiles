--- Handles the `csharp:/metadata` URI scheme used by csharp_ls
--- to display decompiled source from referenced assemblies.
local function buf_read_cmd_handler(bufnr)
  local uri = vim.api.nvim_buf_get_name(bufnr)
  local clients = vim.lsp.get_clients({ name = "csharp_ls" })
  if #clients == 0 then return end

  local client = clients[1]
  client:request("csharp/metadata", { textDocument = { uri = uri } }, function(err, result)
    if err or not result or not result.source then
      vim.notify("csharp_ls: failed to fetch metadata", vim.log.levels.WARN)
      return
    end

    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) then return end
      vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(result.source, "\n"))
      vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
      vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
      vim.api.nvim_set_option_value("filetype", "cs", { buf = bufnr })
      vim.api.nvim_set_option_value("readonly", true, { buf = bufnr })
    end)
  end, bufnr)
end

vim.api.nvim_create_autocmd("BufReadCmd", {
  group = vim.api.nvim_create_augroup("csharp_ls_metadata", { clear = true }),
  pattern = "csharp:/metadata/*",
  callback = function(ev)
    buf_read_cmd_handler(ev.buf)
  end,
})