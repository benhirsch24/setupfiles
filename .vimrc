" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

augroup formatters
   autocmd!
   autocmd BufWritePre * :%s/\s\+$//e
augroup END

let mapleader=","

" Pathogen is important
execute pathogen#infect()

" make sure to create this directory
set backupdir=~/.backups

" Remap movement keys
inoremap jk <ESC>
nnoremap j gj
nnoremap k gk

" Tab with ctrl k/j
nnoremap <C-k> gt
nnoremap <C-j> gT

" Annoyances with highlighting
nnoremap <C-l> :nohl<CR>
" When in visual mode, ctrl-l exits that
vnoremap <C-l> <ESC>
" Align text on "=" using the tabular plugin
vnoremap <leader>= :Tab /=<CR>
" B goes to beginning of line, E goes to end
nnoremap B ^
nnoremap E $

" Commenting these out for now as I'm in a golang shop :'(
"set expandtab
"set shiftwidth=4
"set tabstop=4

" Open nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
" Sets the annoying line here
set cursorline
" Relative line numbers
set relativenumber

" Enables CtrlP fuzzy file searcher
let g:ctrlp_cmd='CtrlP :pwd'

" According to https://vim.fandom.com/wiki/Searching
" If both ignorecase and smartcase are on,
" then searches are case sensitive only if the word contains capitals
set ignorecase
set smartcase

" diff current windows
nnoremap <leader>d :windo diffthis<CR>
" no diff current windows
nnoremap <leader>do :windo diffoff<CR>
