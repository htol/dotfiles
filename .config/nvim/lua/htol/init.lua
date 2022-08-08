if pcall(require, 'lspkind') then
    require("htol.lspkind")
else
    print('=== Error: lspkind failed to load')
end

if pcall(require, 'cmp') then
    require("htol.cmp")
else
    print('=== Error: cmp failed to load')
end

if pcall(require, 'lspconfig') then
    require("htol.lsp")
else
    print('=== Error: lsp failed to load')
end

if pcall(require, 'telescope') then
    require("htol.telescope")
else
    print('=== Error: telescope failed to load')
end

if pcall(require, 'nvim-treesitter.configs') then
    require("htol.treesitter")
else
    print('=== Error: treesitter failed to load')
end
