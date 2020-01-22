
" ------ Colors -----
set t_Co=256
set t_ut=

" ------------------------- General vim config -----------------------------------
syntax enable                              " enable syntax processing
highlight Normal guibg=#333333 guifg=white
set encoding=utf-8
set background=dark
set mouse=a                                " enable the use of the mouse
set whichwrap=b,s,<,>,[,]                  " traverse line break
set tabstop=4                              " number of visual spaces per TAB
set softtabstop=4                          " number of spaces in tab when editing
set expandtab                              " tabs are spaces

set number                                 " show line numbers
set showcmd                                " show command in bottom bar
set cursorline                             " highlight current line
set smartcase                              " case insensitive smart
set ignorecase                             " case insensitive search

filetype indent on                         " load filetype-specific indent files
filetype plugin indent on
set wildmenu                               " visual autocomplete for command menu
set lazyredraw                             " redraw only when we need to.

set showmatch                              " highlight matching [{()}]

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" for session stuff 
set ssop-=options                          " do not store global and local values in a session
set ssop-=folds                            " do not store folds

" Search
set incsearch                              " search as characters are entered
set hlsearch                               " highlight matches

" turn off search highlight with \[space]
nnoremap <leader><space> :nohlsearch<CR>


" Clipboard
"set go+=a                                " Visual selection automatically copied to the clipboard
"set paste                                " Paste from a windows or from vim
set clipboard=unnamedplus

" fold
set nofoldenable                          " disable folding
set foldlevelstart=10                     " open most folds by default
set foldnestmax=10                        " 10 nested fold max
set foldmethod=indent                     " fold based on indent level


" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


" Remember info about open buffers on close
set viminfo^=%

" j and k move through wrapped lines
map j gj
map k gk

" Use h and l to move in wrapped lines
set whichwrap+=h,l

nnoremap J <C-D>
nnoremap K <C-U>

" Insert new line with [enter] in normal mode
nmap <CR> o<Esc>

" Make backspace work normally
set backspace=indent,eol,start

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7 

" Highlight last inserted text
nnoremap gV `[v`]


set wildignore+=*.pyc,*.pyo


" ------------------------- Basic status line -----------------------------------
hi User1 ctermbg=245 ctermfg=235 
hi User2 ctermbg=235 ctermfg=245 
hi User3 ctermbg=235 
hi User4 ctermbg=245 ctermfg=235 
hi User5 ctermbg=245 ctermfg=240 

set laststatus=2

set statusline=
set statusline+=%5*
" set statusline+=\ ‹‹
set statusline+=\ %.40{expand(\"%:~:h\")}/%1*
set statusline+=%{expand(\"%:t\")}
set statusline+=%m
set statusline+=%h 
set statusline+=\  
"set statusline+=%2*%3*
set statusline+=%2*\ %3*
"set statusline+=\ %.20F
set statusline+=%=
"set statusline+=%5*❱%3*
set statusline+=\ %c\ :
set statusline+=\ %l\ /\ %L


" ------------------------- filetype config -----------------------------------
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python setlocal tabstop=4
    autocmd FileType python setlocal shiftwidth=4
    autocmd FileType python setlocal softtabstop=4
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd FileType sh setlocal tabstop=4
    autocmd FileType sh setlocal shiftwidth=4
    autocmd FileType sh setlocal softtabstop=4
    autocmd FileType xml setlocal tabstop=2
    autocmd FileType xml setlocal shiftwidth=2
    autocmd FileType xml setlocal softtabstop=2
    autocmd FileType fortran setlocal softtabstop=2
    autocmd FileType fortran setlocal shiftwidth=2
    autocmd FileType fortran setlocal tabstop=2
    autocmd FileType fortran setlocal textwidth=0
    autocmd BufEnter *.tex setlocal spell
    autocmd BufEnter *.md setlocal spell
    autocmd BufEnter *.pf setlocal commentstring=!\ %s
    autocmd BufEnter *.pf setlocal filetype=fortran
    autocmd BufEnter *.inc setlocal filetype=make
augroup END


" ------ backup ------
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup


" --------------- Fortran --------------
let fortran_free_source=1
let fortran_do_enddo=1


" spell check underline
hi clear SpellBad
hi SpellBad cterm=underline
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u


" Pretty print XML files
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

