set mouse=a
set t_Co=256

let s:portable = expand('<sfile>:p:h')
exe "source " . s:portable . '/colors_init.vim'

"set list
"set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»
" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
