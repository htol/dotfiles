set t_Co=256

if &diff
  set relativenumber
else
"   setup for non-diff mode
endif

"let s:portable = expand('<sfile>:p:h')
"exe "source " . s:portable . '/colors_init.vim'

"set list
"set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

syntax on

" go to next/previous changes in diff and center the line on screen
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap <F5> :w<CR>:!python %<CR>

set runtimepath+=~/.local/vim

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent "smartident

set nu
set relativenumber
set nowrap

" set noswapfile
" set nobackup
" set undodir=~/.config/nvim/vim_undodir
" set undofile

set smartcase
set incsearch

set mouse=a

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

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


call plug#begin('~/.config/nvim/plugged')
" Plug 'mbbill/undotree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

  Plug 'morhetz/gruvbox'
call plug#end()

set background=dark
" let g:gruvbox_contrast_dark = "soft"
colorscheme gruvbox

nnoremap <SPACE> <Nop>
let mapleader =  " "
nnoremap <Leader>W :w !sudo tee % > /dev/null
nnoremap <Leader>w :w
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>b :ls<CR>:b<Space>

vnoremap <leader>p "_dP
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

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

set termguicolors
