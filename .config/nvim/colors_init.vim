let s:portable = expand('<sfile>:p:h')

let s:colors_dir = s:portable . '/colors'

exe 'set rtp+=' . s:colors_dir . '/gruvbox'
" let g:gruvbox_termcolors = 256
let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_contrast_light = "medium"
set bg=dark

" set deafult colorscheme
"colorscheme wombat256mod
"colorscheme seoul256
colorscheme gruvbox
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
