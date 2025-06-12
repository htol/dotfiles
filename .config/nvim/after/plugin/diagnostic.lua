vim.diagnostic.config({
  virtual_lines = true,
  underline = false,
  severity_sort = true,
  update_in_insert = true,
  float = {
    source = true,
    header = "",
    border = "rounded",
  },
  jump = { float = true, wrap = false },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✗",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "∙",
      [vim.diagnostic.severity.HINT] = "∴"
    },
    severity = { min = vim.diagnostic.severity.HINT },
  },
})

vim.keymap.set('n', 'td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
  { desc = 'Toggle diagnostic' })
