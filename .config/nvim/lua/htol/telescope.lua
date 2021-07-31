-- nnoremap <leader>vrc :lua require('htol.telescope').search_dotfiles()<CR>



local M = {}

-- TODO: get output from 'yadm list' to reduce number of files
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = "$HOME/.config/",
    })
end

return M
