set t_Co=256
set termguicolors

if &diff
  set relativenumber
else
"   setup for non-diff mode
endif

syntax on

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" setlocal spell spelllang=ru_yo,en_us

set runtimepath+=~/.local/vim
set tags+=~/.config/nvim/tags
set tags+=~/.local/nvim/nvim-linux64/share/nvim/runtime/doc/tags

set exrc
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
set number relativenumber
set nowrap              " do not wrap line of text
set guicursor=
set nohlsearch
set hidden              " do not unload buffers, keep it in background
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.config/nvim/vim_undodir
set undofile
set smartcase
set incsearch
set scrolloff=8
set colorcolumn=120
set signcolumn=yes

set cmdheight=1
set updatetime=50       " default is 4000ms = 4s

" don't pass messages to |ins-completion-menu|
set shortmess+=c

set mouse=a

set splitbelow
set splitright

if has("autocmd")
  filetype plugin indent on
endif


function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction
set tabline=%!Tabline()


" loadding plugins with packer
lua require('plugins')
lua require("htol")

set background=dark
" let g:gruvbox_contrast_dark = "soft"
try
    colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
endtry
"highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight Normal guibg=none

" TAG JUMPING:
command! MakeTags !ctags -R .
" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" FILE BROWSER:
let g:netrw_banner = 0              " disable banner
let g:netrw_browse_split = 4        " open in prior window
let g:netrw_altv = 1                " open splits to the right
let g:netrw_liststyle = 3           " tree view
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide .= ',\(^\|\s\s)\zs\.\S\+'
" check |netrw-browse-maps| for mappings

" mode lhs rhs
nnoremap <SPACE> <Nop>
let mapleader =  " "

nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<cr>
nnoremap <leader>ff :lua require('telescope.builtin').find_files({hidden = true, file_ignore_patterns = {'.git'}})<cr>
nnoremap <leader>fr :lua require('htol.telescope').search_dotfiles()<CR>
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh :lua require('telescope.builtin').help_tags()<cr>

nnoremap <Leader>W :w !sudo tee % > /dev/null
nnoremap <Leader>w :w
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<cr>
nnoremap <Leader>b :ls<cr>:b<Space>

vnoremap <leader>p "_dP
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

" go to next/previous changes in diff and center the line on screen
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap <F2> :Telescope<CR>
nnoremap <F5> :w<CR>:make<CR>

" more centered views
" zv - open folds
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

nnoremap Y y$

" Undo breakpoints in insert mode
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap = =<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Moving text. Line or selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> :m .+1<CR>==
inoremap <C-k> :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" if executable('rg')
"     let g:rg_derive_root='true'
" endif

func! GetSelectedText()
    normal gv"xy
    let result = getreg("x")
    return result
endfunc

if !has("clipboard") && executable("clip.exe")
    noremap <C-C> :call system('clip.exe', GetSelectedText())<CR>
    noremap <C-X> :call system('clip.exe', GetSelectedText())<CR>gvx
endif


" disable unused providers
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = '/home/tol/.local/pyenv/versions/neovim3/bin/python'

" switch keyboard layouts by C-F instead of C-^
cmap <silent> <C-f> <C-^>
nmap <silent> <C-f> <C-^>
imap <silent> <C-f> <C-^>
vmap <silent> <C-f> <C-^>


augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

autocmd BufWritePre *.go :lua vim.lsp.buf.formatting_sync()

autocmd BufNewFile * silent! 0r $HOME/.config/nvim/templates/%:e.tpl
