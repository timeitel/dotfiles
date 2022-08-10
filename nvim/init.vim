let mapleader = " "
map <leader>to :tabonly<cr>
map <leader>ta :qa<cr>
map <leader>f /
map <leader>F ? 

noremap H ^
noremap L $
noremap n nzz
noremap N Nzz
inoremap kj <Esc>
nnoremap K i<Enter><Esc> 
nnoremap Y yy

" vscode integration :3
nnoremap <leader>m <Cmd>call VSCodeNotify('bookmarks.toggle')<CR>
nnoremap <leader>l <Cmd>call VSCodeNotify('bookmarks.listFromAllFiles')<CR>
nnoremap <leader>n <Cmd>call VSCodeNotify('bookmarks.jumpToNext')<CR>
nnoremap <leader>p <Cmd>call VSCodeNotify('bookmarks.jumpToPrevious')<CR>

nnoremap <leader>fe <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
nnoremap <leader>fs 5[{^WW

set number relativenumber "hybrid line numbers
set history=500
set autoread "auto read when a file is changed from the outside
set cmdheight=1 "height of the command bar
set nohlsearch
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set incsearch
set lazyredraw
set showmatch
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1
set nobackup
set nowb
set noswapfile
set expandtab
set scrolloff=8
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set laststatus=2
set colorcolumn=80

au FocusGained,BufEnter * checktime
syntax on
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=200}
augroup END

call plug#begin()
Plug 'tommcdo/vim-exchange'
Plug 'michaeljsmith/vim-indent-object'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-commentary'
call plug#end()

set bg=dark
colorscheme gruvbox
let g:camelcasemotion_key = '<leader>'
