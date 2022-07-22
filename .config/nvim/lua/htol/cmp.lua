local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
      { name = 'buffer' },
      { name = 'emoji' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
  },
  formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

        -- set a name for each source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        })[entry.source.name]
        return vim_item
      end,
  },

})
