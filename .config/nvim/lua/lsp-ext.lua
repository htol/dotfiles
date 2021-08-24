local api = vim.api
local timer = nil
local triggers_by_buf = {}
local M = {}

local completion_ctx = {
  expand_snippet = false,
  col = nil,
  cancel = {},
}


local function cancel_completion_requests()
  for _, cancel in ipairs(completion_ctx.cancel) do
    cancel()
  end
  completion_ctx.cancel = {}
end


local function text_document_completion_list_to_complete_items(result, prefix)
    local items = vim.lsp.util.extract_completion_items(result)
    if #items == 0 then
        return {}
    end
    if items[1] and items[1].sortText then
        table.sort(items, function(a, b) return (a.sortText or a.label) < (b.sortText or b.label) end)
    end
    local clients = vim.lsp.buf_get_clients(0)
    local equal = 0
    for _, client in ipairs(clients) do
      if client.config.flags.server_side_fuzzy_completion then
        equal = 1
        break
      end
    end
    local matches = {}
    for _, item in ipairs(items) do
        local info = ''
        local documentation = item.documentation
        if documentation then
            if type(documentation) == 'string' and documentation ~= '' then
                info = documentation
            elseif type(documentation) == 'table' and type(documentation.value) == 'string' then
                info = documentation.value
            end
        end
        local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or ''
        local word
        if kind == 'Snippet' then
            word = item.label
        elseif item.insertTextFormat == 2 then -- 2 == snippet
            --[[
            -- eclipse.jdt.ls has
            --      insertText = "wait",
            --      label = "wait() : void"
            --      textEdit = { ... }
            --
            -- haskell-ide-engine has
            --      insertText = "testSuites ${1:Env}"
            --      label = "testSuites"
            --]]
            if item.textEdit then
                word = item.insertText
            else
                word = item.label
            end
        else
            word = (item.textEdit and item.textEdit.newText) or item.insertText or item.label
        end
        if equal == 1 or vim.startswith(word, prefix) then
          table.insert(matches, {
              word = word,
              abbr = item.label,
              kind = kind,
              menu = item.detail or '',
              info = info,
              icase = 1,
              dup = 1,
              empty = 1,
              equal = equal,
              user_data = item
          })
        end
    end
    return matches
end


function M.trigger_completion()
  cancel_completion_requests()
  local bufnr = api.nvim_get_current_buf()
  local cursor_pos = api.nvim_win_get_cursor(0)[2]
  local line = api.nvim_get_current_line()
  local col
  if completion_ctx.col then
    col = completion_ctx.col
  else
    local line_to_cursor = line:sub(1, cursor_pos)
    local idx = 0
    while true do
      local i = string.find(line_to_cursor, '[^a-zA-Z0-9_]', idx + 1)
      if i == nil then
        break
      else
        idx = i
      end
    end
    col = (idx or col) + 1
    completion_ctx.col = col
  end
  local prefix = line:sub(col, cursor_pos)
  local params = vim.lsp.util.make_position_params()
  local _, cancel_completions = vim.lsp.buf_request(
    bufnr,
    'textDocument/completion',
    params,
    function(err, _, result)
      if err then
        print('Error getting completions: ' .. err.message)
        return
      end
      if not result then
        print('no completion result')
        return
      end
      local mode = api.nvim_get_mode()['mode']
      if mode == 'i' or mode == 'ic' then
        local matches = text_document_completion_list_to_complete_items(result, prefix)
        vim.fn.complete(col, matches)
      end
    end
  )
  table.insert(completion_ctx.cancel, cancel_completions)
end


function M._InsertCharPre(server_side_fuzzy_completion)
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
  local char = api.nvim_get_vvar('char')
  local triggers = triggers_by_buf[api.nvim_get_current_buf()] or {}
  for _, entry in pairs(triggers) do
    local chars, fn = unpack(entry)
    if vim.tbl_contains(chars, char) then
      completion_ctx.col = nil
      timer = vim.loop.new_timer()
      timer:start(150, 0, vim.schedule_wrap(fn))
      return
    end
  end
  if server_side_fuzzy_completion and tonumber(vim.fn.pumvisible()) == 1 then
    timer = vim.loop.new_timer()
    timer:start(250, 0, vim.schedule_wrap(M.trigger_completion))
  end
end


function M._InsertLeave()
    if timer then
        timer:stop()
        timer:close()
        timer = nil
    end
    cancel_completion_requests()
    completion_ctx.col = nil
end


function M._CompleteChanged()
  completion_ctx.additionalTextEdits = nil
  cancel_completion_requests()
  local completed_item = api.nvim_get_vvar('completed_item')
  if not completed_item or not completed_item.user_data then
    return
  end
  local _, cancel_req = vim.lsp.buf_request(
    0,
    'completionItem/resolve',
    completed_item.user_data,
    function(err, _, result)
      if err then
        print('Error on completionItem/resolve: ', err.message)
        return
      end
      completion_ctx.additionalTextEdits = result and result.additionalTextEdits
    end
  )
  table.insert(completion_ctx.cancel, cancel_req)
end


function M._CompleteDone()
    local completion_start_idx = completion_ctx.col
    local resolved_additionalTextEdits = completion_ctx.additionalTextEdits
    completion_ctx.additionalTextEdits = nil
    completion_ctx.col = nil
    cancel_completion_requests()
    local completed_item = api.nvim_get_vvar('completed_item')
    if not completed_item or not completed_item.user_data then
      return
    end
    local lnum, col = unpack(api.nvim_win_get_cursor(0))
    lnum = lnum - 1
    local item = completed_item.user_data
    if type(item) == 'string' then
      return
    end
    local bufnr = api.nvim_get_current_buf()
    local expand_snippet = item.insertTextFormat == 2 and completion_ctx.expand_snippet
    completion_ctx.expand_snippet = false
    local suffix = nil

    if expand_snippet then
      -- Create textEdit to remove the already inserted word
      local start_char = completion_start_idx and (completion_start_idx - 1) or (col - #completed_item.word)
      local line = api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, true)[1]
      suffix = line:sub(col + 1)
      local text_edit = {
        range = {
          ["start"] = {
            line = lnum;
            character = start_char;
          };
          ["end"] = {
            line = lnum;
            character = #line;
          }
        };
        newText = "";
      }
      vim.lsp.util.apply_text_edits({text_edit}, bufnr)
    end

    if not item.additionalTextEdits then
      item.additionalTextEdits = resolved_additionalTextEdits
    end
    if item.additionalTextEdits then
      -- Text edit in the same line would mess with the cursor position
      local edits = vim.tbl_filter(
        function(x) return x.range.start.line ~= lnum end,
        item.additionalTextEdits
      )
      local ok, err = pcall(vim.lsp.util.apply_text_edits, edits, bufnr)
      if not ok then
        print(err, vim.inspect(edits))
      end
    end
    if expand_snippet then
      if item.textEdit then
        api.nvim_call_function("UltiSnips#Anon", {item.textEdit.newText .. suffix})
      else
        api.nvim_call_function("UltiSnips#Anon", {item.insertText .. suffix})
      end
    end
end



function M.accept_pum()
    if tonumber(vim.fn.pumvisible()) == 0 then
        return false
    else
        completion_ctx.expand_snippet = true
        return true
    end
end


function M.setup()
  vim.lsp.util.text_document_completion_list_to_complete_items = text_document_completion_list_to_complete_items
end


function M.attach(client, bufnr)
  vim.cmd(string.format(
    "autocmd InsertCharPre <buffer=%d> lua require'lsp-ext'._InsertCharPre(%s)",
    bufnr,
    client.config.flags.server_side_fuzzy_completion
  ))
  vim.cmd(string.format("autocmd InsertLeave <buffer=%d> lua require'lsp-ext'._InsertLeave()", bufnr))
  vim.cmd(string.format("autocmd CompleteDone <buffer=%d> lua require'lsp-ext'._CompleteDone()", bufnr))
  if (client.server_capabilities.completionProvider or {}).resolveProvider then
    vim.cmd(string.format("autocmd CompleteChanged <buffer=%d> lua require'lsp-ext'._CompleteChanged()", bufnr))
  end
  local triggers = triggers_by_buf[bufnr]
  if not triggers then
    triggers = {}
    triggers_by_buf[bufnr] = triggers
    api.nvim_buf_attach(bufnr, false, {
      on_detach = function(_, b)
        triggers_by_buf[b] = nil
      end
    })
  end
  local signature_triggers = client.resolved_capabilities.signature_help_trigger_characters
  if signature_triggers and #signature_triggers > 0 then
    table.insert(
      triggers, { signature_triggers, vim.lsp.buf.signature_help }
    )
  end
  local completionProvider = client.server_capabilities.completionProvider or {}
  local completion_triggers = completionProvider.triggerCharacters
  if completion_triggers and #completion_triggers > 0 then
    table.insert(
      triggers, { completion_triggers, M.trigger_completion }
    )
  end
end


function M.tagfunc(pattern, flags)
  if flags ~= 'c' then
    return vim.NIL
  end
  local params = vim.lsp.util.make_position_params()
  local client_id_to_results, err = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 500)
  assert(not err, vim.inspect(err))

  local results = {}
  for _, lsp_results in ipairs(client_id_to_results) do
    for _, location in ipairs(lsp_results.result or {}) do
      local start = location.range.start
      table.insert(results, {
        name = pattern,
        filename = vim.uri_to_fname(location.uri),
        cmd = string.format(
          'call cursor(%d, %d)', start.line + 1, start.character + 1
        )
      })
    end
  end
  return results
end

return M
