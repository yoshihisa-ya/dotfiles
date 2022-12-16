" vim: set foldmethod=marker :

" Plugin {{{
" ------

call plug#begin()

" bundle LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" comment
Plug 'tomtom/tcomment_vim'

" markdown
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'

" bash
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" indent
Plug 'nathanaelkane/vim-indent-guides'

" display
" Plug 'petertriho/nvim-scrollbar'

" move
Plug 'easymotion/vim-easymotion'

" filer
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

" japanese
Plug 'fuenor/JpFormat.vim'
Plug 'skanehira/translate.vim'
Plug 'tyru/eskk.vim'

call plug#end()
" }}}

" Plugin config {{{
" -------------
" tryu/eskk.vim
let g:eskk#directory = "~/.config/eskk"
let g:eskk#dictionary = { 'path': "~/.config/ibus-skk/user.dict", 'sorted': 0, 'encoding': 'euc-jp',}
let g:eskk#large_dictionary = {'path': "/usr/share/skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',}

" easymotion/vim-easymotion
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" lewis6991/gitsigns.nvim
lua << END
require('gitsigns').setup {
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text_pos = 'right_align',
    delay = 100,
  },
}
END

" nvim-lualine/lualine.nvim
lua << END
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'material',
  },
}
END

" petertriho/nvim-scrollbar
" lua << END
"   require("scrollbar").setup({
"       show = true,
"       set_highlights = true,
"       handle = {
"           text = " ",
"           color = nil,
"           cterm = nil,
"           highlight = "CursorColumn",
"           hide_if_all_visible = true,
"       },
"       marks = {
"           Search = {
"               text = { "-", "=" },
"               priority = 0,
"               color = nil,
"               cterm = nil,
"               highlight = "Search",
"           },
"           Error = {
"               text = { "-", "=" },
"               priority = 1,
"               color = nil,
"               cterm = nil,
"               highlight = "DiagnosticVirtualTextError",
"           },
"           Warn = {
"               text = { "-", "=" },
"               priority = 2,
"               color = nil,
"               cterm = nil,
"               highlight = "DiagnosticVirtualTextWarn",
"           },
"           Info = {
"               text = { "-", "=" },
"               priority = 3,
"               color = nil,
"               cterm = nil,
"               highlight = "DiagnosticVirtualTextInfo",
"           },
"           Hint = {
"               text = { "-", "=" },
"               priority = 4,
"               color = nil,
"               cterm = nil,
"               highlight = "DiagnosticVirtualTextHint",
"           },
"           Misc = {
"               text = { "-", "=" },
"               priority = 5,
"               color = nil,
"               cterm = nil,
"               highlight = "Normal",
"           },
"       },
"       excluded_buftypes = {
"           "terminal",
"       },
"       excluded_filetypes = {
"           "prompt",
"           "TelescopePrompt",
"       },
"       autocmd = {
"           render = {
"               "BufWinEnter",
"               "TabEnter",
"               "TermEnter",
"               "WinEnter",
"               "CmdwinLeave",
"               "TextChanged",
"               "VimResized",
"               "WinScrolled",
"           },
"       },
"       handlers = {
"           diagnostic = true,
"           search = true,
"       },
"   })
" END

" LSP
lua << END
  local cmp = require'cmp'

  cmp.setup({
  snippet = {
    expand = function(args)
    vim.fn["vsnip#anonymous"](args.body)
    end,
    },
  mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
      sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      }, {
      { name = 'buffer' },
      }, {
      { name = 'calc' },
      })
    })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
      }
    })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
    { name = 'cmdline' }
    })
  })

  local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {}
    opts.on_attach = on_attach
    opts.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    server:setup(opts)
  end)
END

" z0mbix/vim-shfmt
let g:shfmt_extra_args = '-i 4'
let g:shfmt_fmt_on_save = 1

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1

" Shougo/defx.nvim
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
call defx#custom#option('_', {
      \ 'winwidth': 50,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'exlorer',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ })

" }}}

" Basic {{{
" -----

syntax enable      " シンタックスハイライト
set mouse=a        " マウス有効
set title          " タイトルを設定
set modeline       " モードライン
set cursorline     " カーソル行をハイライト
set nocursorcolumn " カーソルカラムをハイライトしない
set nobackup       " バックアップファイルを作成しない
set noswapfile     " スワップファイルを作成しない
set hidden         " 未保存バッファを許容する
set autowrite      " 一部コマンドで自動保存する
set autoread       " 自動的に読み直す
" }}}

" Keybind {{{
" -------

noremap <C-n> :cnext<CR>
noremap <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
let mapleader=","
" 日付を入力する
nnoremap <C-o><C-o> <ESC>i<C-R>=strftime("%Y-%m-%d")<CR>
" C-jでC-^とする
nnoremap <C-j> <C-^>
" 探索結果を中心とする
nnoremap n nzz
nnoremap N Nzz
" ZZ無効化
nnoremap ZZ <Nop>
" Shougo/defx.nvim
nnoremap <silent> <Leader>f :<C-u> Defx -toggle<CR>
"}}}

" Display {{{
" -------

set number " 行番号
set ruler  " ルーラー
set list listchars=tab:^_,trail:_ " 不可視文字

" 全角スペースをハイライト
scriptencoding utf-8
augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" colorscheme
set termguicolors
colorscheme morning

" Git commit で差分を表示
autocmd FileType gitcommit DiffGitCached | wincmd x | resize 10

" 最後の編集位置にカーソルを復元
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" cmdline & statusline
set cmdheight=1  " コマンドラインバッファ行数
set laststatus=2 " ステータスラインを常に出力
"let ff_type = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
"set statusline=%f%m%=%r%h%w%{FugitiveStatusline()}[%Y,%{ff_type[&ff]}(%{&ff})][%{(&fenc!=''?&fenc:&enc)}][%03l/%03L,%03c][%02p%%]
" }}}

" Code format {{{
" -----------

" Indent
set expandtab     " tab の代わりに space を利用する
set tabstop=2     " ハードタブを指定空白として表示する
set softtabstop=0 " tab の代わりに指定空白を入力する
set shiftwidth=2  " 自動インデントに利用される空白数
set autoindent    " 改行した際にインデントを継続する
" set smartindent " C-likeなインデントを行う
set cindent       " Cプログラムファイルのインデントを行う
set showmatch     " 対応する括弧にわずかにジャンプする
autocmd FileType * setlocal formatoptions-=ro " 自動コメントアウトを無効にする

augroup foldmethod
  autocmd!
  autocmd FileType sh setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=0
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
augroup END
" }}}

" Search {{{
"-------

set ignorecase " 大文字, 小文字を無視する
set smartcase  " 大文字を含む場合は区別する
set incsearch  " インクリメンタルサーチ
set hlsearch   " ハイライトする
set wrapscan   " 末尾の次に先頭に戻る
" ハイライトの解除
nnoremap <ESC><ESC> :nohlsearch<CR>
" }}}
