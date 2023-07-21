if pcall(require, 'lspkind') then
    require("htol.lspkind")
else
    print('=== Error: lspkind failed to load')
end

if pcall(require, 'symbols-outline') then
    require("htol.symbols-outline")
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
