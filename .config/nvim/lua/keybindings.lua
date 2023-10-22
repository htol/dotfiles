local map = vim.keymap.set

map("n", "<Space>", "<Nop>")

map("n", "<Leader>W", ":w !sudo tee % > /dev/null")
map("n", "<Leader>w", ":w")
map("n", "<Leader><CR>", ":so ~/.config/nvim/init.vim<cr>")
map("n", "<Leader>b", ":ls<cr>:b<Space>")

map("v", "<Leader>p", "\"_dP")
--vnoremap J :m '>+1<CR>gv=gv
--vnoremap K :m '<-2<CR>gv=gv

-- Telescope
map("n", "<Leader>ps", function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")}) end)
map("n", "<leader>ff", function() require('telescope.builtin').find_files({hidden = true, file_ignore_patterns = {'.git', '.venv', 'venv', 'node_modules'}}) end)
map("n", "<leader>fr", function() require('htol.telescope').search_dotfiles() end)
map("n", "<leader>fg", function() require('telescope.builtin').live_grep() end)
map("n", "<leader>fb", function() require('telescope.builtin').buffers() end)
map("n", "<leader>fh", function() require('telescope.builtin').help_tags() end)
map("n", "<leader>fx", require('telescope.builtin').resume, {noremap=true, silent=true, desc="Resume last picker"})

-- go to next/previous changes in diff and center the line on screen
map("n", "]c", "]czz")
map("n", "[c", "[czz")
map("n", "<F2>", ":Telescope<CR>")
--map("n", "<F5>", ":w<CR>:make<CR>")

-- more centered views
-- zv - open folds
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

map("n", "Y", "y$")

-- Undo breakpoints in insert mode
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "(", "(<c-g>u")
map("i", ")", ")<c-g>u")
map("i", "=", "=<c-g>u")

-- Jumplist mutations
map("n", "k", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'", {expr=true})
map("n", "j", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'", {expr=true})

-- Moving text. Line or selection
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("i", "<C-j>", ":m .+1<CR>==")
map("i", "<C-k>", ":m .-2<CR>==")
map("n", "<Leader>j", ":m .+1<CR>==")
map("n", "<Leader>k", ":m .-2<CR>==")

-- switch keyboard layouts by C-F instead of C-^
map({"c", "n", "i", "v"}, "<C-f>", "<C-^>", {remap=true, silent=true})

-- In WSL copy to windows clipboard via clip.exe
-- TODO: implement in lua
--func! GetSelectedText()
--    normal gv"xy
--    let result = getreg("x")
--    return result
--endfunc
--
--if !has("clipboard") && executable("clip.exe")
--    noremap <C-C> :call system('clip.exe', GetSelectedText())<CR>
--    noremap <C-X> :call system('clip.exe', GetSelectedText())<CR>gvx
--endif
