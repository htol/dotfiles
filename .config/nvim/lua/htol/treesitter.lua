require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "go", "python", "c", "cpp", "bash", "html", "javascript",
        "json", "yaml", "lua", "vue", "java", "kotlin", "hcl"
    },
    highlight = { enable = true },
}
