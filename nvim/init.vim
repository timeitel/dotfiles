inoremap kj <Esc>
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
nnoremap n nzz
nnoremap N Nzz
nnoremap K i<Enter><Esc> 
nnoremap Y yy

let mapleader = " "
map <leader>to :tabonly<cr>
map <leader>ta :qa<cr>
" try find fn signature 
nnoremap <leader>fs 5[{^WW
nnoremap <leader>i i <Esc>i
nnoremap <leader>oi :e ~/.dotfiles/nvim/init.vim

" vscode integration :3
nnoremap <leader>m <Cmd>call VSCodeNotify('bookmarks.toggle')<CR>
nnoremap <leader>M <Cmd>call VSCodeNotify('bookmarks.toggleLabeled')<CR>
nnoremap <leader>l <Cmd>call VSCodeNotify('bookmarks.listFromAllFiles')<CR>
nnoremap <leader>n <Cmd>call VSCodeNotify('bookmarks.jumpToNext')<CR>
nnoremap <leader>p <Cmd>call VSCodeNotify('bookmarks.jumpToPrevious')<CR>
nnoremap <leader>gR <Cmd>call VSCodeNotify('git.undoCommit')<CR>
nnoremap <leader>gr <Cmd>call VSCodeNotify('git.cleanAll')<CR>
nnoremap <leader>gU <Cmd>call VSCodeNotify('git.unstage')<CR>
nnoremap <leader>gu <Cmd>call VSCodeNotify('git.unstageAll')<CR>
nnoremap <leader>gA <Cmd>call VSCodeNotify('git.stage')<CR>
nnoremap <leader>ga <Cmd>call VSCodeNotify('git.stageAll')<CR>
nnoremap <leader>gg <Cmd>call VSCodeNotify('git.commitAll')<CR>
nnoremap <leader>gh <Cmd>call VSCodeNotify('git-graph.view')<CR>
nnoremap <leader>gp <Cmd>call VSCodeNotify('git.push')<CR>
nnoremap <leader>fe <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>

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
Plug 'bkad/CamelCaseMotion'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'michaeljsmith/vim-indent-object'
Plug 'morhetz/gruvbox'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

set bg=dark
colorscheme gruvbox
let g:camelcasemotion_key = '<leader>'
