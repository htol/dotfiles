local function lsp_progress()
  local messages = vim.lsp.status()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

local function short_hostname()
    local fqdn = vim.loop.os_gethostname()
    _, _, host = string.find(fqdn, "^(.-)%..*$")
  return host
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    --theme = 'gruvbox',
    theme = 'lunar',
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {},
  },
 sections = {
     lualine_c = {
         'filename',
         {lsp_progress},
     },
     lualine_x = {
      { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
        hint = ' ' } },
      'encoding',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = {'location', {short_hostname}}
 },
}

