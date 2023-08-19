local ok, cmp = pcall(require, 'cmp')
if not ok then
    return
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

local ok, luasnip = pcall(require, 'luasnip')
if not ok then
    return
end

-- set completeopt=menuone,noinsert,noselect
vim.opt.completeopt = {"menu", "menuone", "noselect"}
-- don't pass messages to |ins-completion-menu|
vim.opt.shortmess:append "c"

cmp.setup {
  snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
    ["<M-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      { "i", "c" }
    ),
    ["<C-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },
        ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },

  sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 5 },
      { name = 'emoji' },
  },

  formatting = {
      format = lspkind.cmp_format {
          with_text = true,
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            luasnip = "[snip]",
            path = "[path]",
            latex_symbols = "[Latex]",
        },
      },
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}
