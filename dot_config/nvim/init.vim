" vim: set foldmethod=marker :

" Plugin {{{
" ------

call plug#begin()

" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'j-hui/fidget.nvim'

Plug 'ErichDonGubler/lsp_lines.nvim'

" tag
Plug 'vim-scripts/gtags.vim'

" telescope.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'kkharji/sqlite.lua'

" tab
Plug 'akinsho/bufferline.nvim'

" statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" file explorer
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'MunifTanjim/nui.nvim'

" git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" comment
Plug 'tomtom/tcomment_vim'

" markdown
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'

" indent
Plug 'lukas-reineke/indent-blankline.nvim'

" autopair
Plug 'windwp/nvim-autopairs'

" color highlighter
Plug 'norcalli/nvim-colorizer.lua'

" display
" Plug 'petertriho/nvim-scrollbar'

" move
Plug 'easymotion/vim-easymotion'

" filer
" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

" japanese
Plug 'fuenor/JpFormat.vim'
Plug 'skanehira/translate.vim'
Plug 'tyru/eskk.vim'

" search
Plug 'kevinhwang91/nvim-hlslens'

call plug#end()
" }}}

let mapleader=","

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

" j-hui/fidget.nvim
lua << EOF
require"fidget".setup{}
EOF

" akinsho/bufferline.nvim
lua << EOF
vim.opt.termguicolors = true
require("bufferline").setup{}
EOF

" nvim-telescope/telescope.nvim
lua << EOF
local builtin = require('telescope.builtin')
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
      }
    }
  }
require('telescope').load_extension('fzf')
require('telescope').load_extension('frecency')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fF', function() builtin.find_files({hidden = true, no_ignore = true}) end, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
vim.keymap.set('n', '<leader>fo', function () require('telescope').extensions.frecency.frecency() end, {})
vim.keymap.set('n', '<leader>f<CR>', builtin.resume, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gt', builtin.git_status, {})
vim.keymap.set('n', '<leader>gd', function() require("gitsigns").diffthis() end, {})
vim.keymap.set('n', '<leader>gl', function() require("gitsigns").blame_line() end, {})
vim.keymap.set('n', '<leader>gs', function() require("gitsigns").stage_hunk() end, {})
vim.keymap.set('n', '<leader>gS', function() require("gitsigns").stage_buffer() end, {})
vim.keymap.set('n', '<leader>gu', function() require("gitsigns").undo_stage_hunk() end, {})
EOF
" nnoremap <silent> <Leader>,g :GFiles<CR>
" nnoremap <silent> <Leader>,G :GFiles?<CR>
" nnoremap <silent> <Leader>,f :Files<CR>
" nnoremap <silent> <Leader>,r :Rg<CR>
" nnoremap <silent> <Leader>,c :Commits<CR>
" nnoremap <silent> <Leader>,b :Buffers<CR>
" nnoremap <silent> <Leader>,h :History<CR>

" ErichDonGubler/lsp_lines.nvim
lua << EOF
require("lsp_lines").setup()
EOF

" windwp/nvim-autopairs
lua << EOF
require("nvim-autopairs").setup {}
EOF

" kevinhwang91/nvim-hlslens
lua << EOF
require('hlslens').setup()
EOF

" nvim-lualine/lualine.nvim
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'material',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    colored = true,
    globalstatus = false,
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

  require("mason").setup()
  require("mason-lspconfig").setup()
  require("mason-lspconfig").setup_handlers {
    function (server_name)
      require("lspconfig")[server_name].setup {}
    end
  }

  local null_ls = require("null-ls")
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  null_ls.setup({
      sources = {
          null_ls.builtins.formatting.shfmt.with({
              extra_args = { "-i", "4" },
          }),
      },
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                      vim.lsp.buf.format({ bufnr = bufnr })
                      -- vim.lsp.buf.formatting_sync()
                  end,
              })
          end
      end,
  })

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
  ['<Tab>'] = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      fallback()
    end
  end,
  ['<S-Tab>'] = function(fallback)
    if cmp.visivle() then
      cmp.select_prev_item()
    else
      fallback()
    end
  end,
  }),
      sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
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

END

" vim-indent-guides
" let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1
lua << END
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true

require("indent_blankline").setup {
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
END

" Gtags
let Gtags_Auto_Map = 1

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
" 日付を入力する
nnoremap <C-o><C-o> <ESC>i<C-R>=strftime("%Y-%m-%d")<CR>
" C-jでC-^とする
nnoremap <C-j> <C-^>
" 探索結果を中心とする
nnoremap n nzz
nnoremap N Nzz
" ZZ無効化
nnoremap ZZ <Nop>
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
" colorscheme morning
set termguicolors

" norcalli/nvim-colorizer.lua
lua require'colorizer'.setup()

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
