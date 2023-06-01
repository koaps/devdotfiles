set nocompatible
filetype off

let mapleader=" "

" set mouse=a
set mouse=

let &winheight = &lines * 10 / 10

set nopaste

"turn on airline status bar
set laststatus=2

"set textwidth=79  " lines longer than 79 columns will be broken

set hidden
set wrap        " don't wrap lines
set tabstop=4     " a tab is 2 spaces
set softtabstop=4 " insert/delete 2 spaces when hitting a TAB/BACKSPACE

set backspace=indent,eol,start
                    " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set cindent
"set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
"set ignorecase    " ignore case when searching
"set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                    "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

" nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<leader>p

set list
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:.
"set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

set expandtab     " don't use actual tab character

" Show column rulers
" set colorcolumn=72,80

highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction

set t_u7=
set t_RV=
