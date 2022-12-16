" Basic
" ------------------------------

syntax enable

set title
" set modeline

set cursorline
set nocursorcolumn

set nobackup
set noswapfile

set hidden
set autoread


" Map
" ------------------------------

" ペースト範囲をビジュアル選択する
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" 日付を入力する
nmap <C-o><C-o> <ESC>i<C-R>=strftime("%Y-%m-%d")<CR>

" C-jでC-^とする
nnoremap <C-j> <C-^>

" 探索結果を中心とする
nmap n nzz
nmap N Nzz

" ZZ無効化
nmap ZZ <Nop>


" Display
" ------------------------------

" 行数とルーラーを表示
set number
set ruler

" 不可視文字を表示
set list listchars=tab:^_,trail:_

" 全角スペースをハイライト
scriptencoding utf-8
augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" colorscheme
colorscheme elflord

" Git commit で差分を表示
autocmd FileType gitcommit DiffGitCached | wincmd x | resize 10

" 最後の編集位置にカーソルを復元
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" cmdline & statusline
set cmdheight=2
set laststatus=2
let ff_type = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
set statusline=%=%m%r%h%w%{FugitiveStatusline()}[%Y,%{ff_type[&ff]}(%{&ff})][%{(&fenc!=''?&fenc:&enc)}][%03l/%03L,%03c][%02p%%]


" Code format
" ------------------------------

" Indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0
set autoindent
" set smartindent
set cindent
set showmatch

augroup foldmethod
  autocmd!
  autocmd FileType sh setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
augroup END


" Search
" ------------------------------

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
set wrapscan
nnoremap <ESC><ESC> :nohlsearch<CR>
