local map = vim.keymap.set
local file_ignore_patterns = {
    '.git/', '.venv', 'venv',
    'node_modules', 'vim_undodir/', 'repo.git', 'plugged',
    'google-chrome/', 'BraveSoftware/', 'discord/', 'go/',
}

-- TODO: get output from 'yadm list' to reduce number of files
local search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = "$HOME/.config/",
        file_ignore_patterns = file_ignore_patterns
    })
end

map("n", "<leader>uc", function() require('telescope.builtin').colorscheme({enable_preview = true}) end, {noremap=true, silent=true, desc="Change colorscheme"})
map("n", "<Leader>ps", function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")}) end)
map("n", "<leader>ff", function() require('telescope.builtin').find_files(
    {
        hidden = true,
        file_ignore_patterns = file_ignore_patterns
    }) end)
map("n", "<leader>fr", search_dotfiles)
map("n", "<leader>fg", function() require('telescope.builtin').live_grep() end)
map("n", "<leader>fb", function() require('telescope.builtin').buffers() end)
map("n", "<leader>fh", function() require('telescope.builtin').help_tags() end)
map("n", "<leader>fx", require('telescope.builtin').resume, {noremap=true, silent=true, desc="Resume last picker"})


return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
    },
}
