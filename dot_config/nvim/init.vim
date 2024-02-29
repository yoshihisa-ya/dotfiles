" vim: set foldmethod=marker :

let mapleader=","
set list listchars=tab:^_,trail:_ " 不可視文字
set termguicolors
lua << EOF
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
EOF

" Plugin {{{
" ------

lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
      require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'material',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        colored = true,
        globalstatus = true,
        },
        extensions = {
          "neo-tree"
        }
        })
      end,
  },
  {
      "nvim-treesitter/nvim-treesitter",
      config = function()
      require('nvim-treesitter.configs').setup({
      ensure_installed ={ "c", "lua", "vim", "vimdoc", "bash", "c_sharp", "git_config", "git_rebase", "html", "jq", "json", "latex", "make", "markdown", "muttrc", "printf", "promql", "python", "rst", "ssh_config", "strace", "systemtap", "terraform", "toml", "xml", "yaml"},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        },
      })
      end,
      build = ':TSUpdate',
  },
  {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
      })
      end,
  },
  {
      "nvim-telescope/telescope.nvim", tag = '0.1.1',
      dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-frecency.nvim", dependencies = {
            "kkharji/sqlite.lua",
            "nvim-tree/nvim-web-devicons"
            }
        },
      },
      config = function()
      local builtin = require('telescope.builtin')
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('frecency')
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })
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
      end,
  },
  {
      'akinsho/toggleterm.nvim',
      config = true,
      opts = {
        open_mapping = [[<c-\>]],
        vim.keymap.set('n', '<leader>tf', "<cmd>ToggleTerm direction=float<cr>", {})
      }
  },
  {
      'akinsho/bufferline.nvim',
      version = "*",
      dependencies = 'nvim-tree/nvim-web-devicons',
      opts = {
        options = {
          numbers = "none",
          indicator = {
            style= 'none'
          },
          diagnostics = "nvim_lsp",
          offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                text_align = "left",
                separator = true

            }
          },
        },
      },
  },
  {
      'nvim-neo-tree/neo-tree.nvim',
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      opts = {
        window = {
          position = "left",
          width = 30
        },
        vim.keymap.set('n', '<leader>fe', "<cmd>Neotree toggle<cr>", {})
      }
  },
  {
      'lewis6991/gitsigns.nvim',
      opts = {
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text_pos = 'right_align',
          delay = 100,
        },
        vim.keymap.set('n', '<leader>gd', function() require("gitsigns").diffthis() end, {}),
        vim.keymap.set('n', '<leader>gl', function() require("gitsigns").blame_line() end, {}),
        vim.keymap.set('n', '<leader>gs', function() require("gitsigns").stage_hunk() end, {}),
        vim.keymap.set('n', '<leader>gS', function() require("gitsigns").stage_buffer() end, {}),
        vim.keymap.set('n', '<leader>gu', function() require("gitsigns").undo_stage_hunk() end, {})
      }
  },
  {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      config = true,
  },
  {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        "neovim/nvim-lspconfig",
      },
      config = function()
        local on_attach = function(client, bufnr)
          local opts = { noremap=true, silent=true }
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
          vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
          vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
          vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
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
        require('mason-lspconfig').setup({
          ensure_installed = {
            "awk_ls",
            "ansiblels",
            "bashls",
            "clangd",
            "dockerls",
            "docker_compose_language_service",
            -- "gopls",
            "html",
            "jsonls",
            "texlab",
            "lua_ls",
            "marksman",
            "esbonio",
          },
        })
        require('mason-lspconfig').setup_handlers {
          function (server_name)
            require("lspconfig")[server_name].setup {
              on_attach = on_attach
            }
          end
        }
      end,
  },
  {
      "jose-elias-alvarez/null-ls.nvim",
      -- :MasonInstall shellcheck shfmt
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
          sources = {
              null_ls.builtins.formatting.shfmt.with({
                  extra_args = { "-i", "4" },
              }),
          },
          on_attach = function(client, bufnr)
              if client.supports_method("textDocument/formatting") then
                  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                  vim.api.nvim_create_autocmd("BufWritePre", {
                      group = augroup,
                      buffer = bufnr,
                      callback = function()
                          vim.lsp.buf.format({ bufnr = bufnr })
                      end,
                  })
              end
          end,
        })
      end,
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/cmp-calc'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-vsnip'},
  {'hrsh7th/vim-vsnip'},
  {'hrsh7th/vim-vsnip-integ'},
  {
      'j-hui/fidget.nvim',
      tag = "legacy",
      config= true
  },
  {
      'ErichDonGubler/lsp_lines.nvim'
  },
  {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      -- opts = {
      --   space_char_blankline = " ",
      --   show_current_context = true,
      --   show_current_context_start = true,
      -- }

  },
  {
      'vim-skk/skkeleton',
      dependencies = 'vim-denops/denops.vim',
      config = function()
        vim.fn["skkeleton#config"]({
          globalDictionaries = {"/usr/share/skk/SKK-JISYO.L"}
        })
        vim.fn["skkeleton#initialize"]()
      end,
  },
  {
      "numToStr/Comment.nvim",
      config = true,
  },
  {
      "s1n7ax/nvim-comment-frame",
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = true,
  },
  {
      "danymat/neogen", 
      dependencies = "nvim-treesitter/nvim-treesitter",
      config = true,
  },
  {
      "andymass/vim-matchup",
      config = true,
  },
  {
      "windwp/nvim-autopairs",
      config = true,
  },
  {
      "norcalli/nvim-colorizer.lua", -- # TODO: 動作していないので確認する。
      config = true,
  },
  {
      "kevinhwang91/nvim-hlslens",
      config = true,
  },
  { "vim-scripts/gtags.vim" },
  { "voldikss/vim-translator" },
  { "fuenor/JpFormat.vim" },
  {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      build = function()
      vim.fn["mkdp#util#install"]()
      end,
  },
  {
      "phaazon/hop.nvim",
      config = function()
      require('hop').setup()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 'f', function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
      end, {remap=true})
      vim.keymap.set('', 'F', function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
      end, {remap=true})
      end
  },
  {'segeljakt/vim-silicon'},
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

EOF


" Plugin config {{{
" -------------
" vim-skk/skkeleton
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)

" Gtags
let Gtags_Auto_Map = 1

" voldikss/vim-translator
let g:translator_target_lang = "ja"
let g:translator_default_engines = ['google']

" segeljakt/vim-silicon
let g:silicon = {
      \   'pad-horiz':                                   0,
      \   'pad-vert':                                    0,
      \   'output': '~/silicon-{time:%Y-%m-%d-%H%M%S}.png',
      \   'window-controls':                       v:false,
      \ }

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
set backupcopy=yes
set hidden         " 未保存バッファを許容する
set autowrite      " 一部コマンドで自動保存する
set autoread       " 自動的に読み直す
" }}}

" Keybind {{{
" -------

noremap <C-n> :cnext<CR>
noremap <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
" C-jでC-^とする
"nnoremap <C-j> <C-^>
" 探索結果を中心とする
nnoremap n nzz
nnoremap N Nzz
" ZZ無効化
nnoremap ZZ <Nop>
"}}}

" Display {{{
" -------

set number relativenumber" 行番号
set ruler  " ルーラー
" set list listchars=tab:^_,trail:_ " 不可視文字
hi Comment gui=NONE

" 全角スペースをハイライト
scriptencoding utf-8
augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" colorscheme
" colorscheme tokyonight
set pumblend=10

" Git commit で差分を表示
autocmd FileType gitcommit DiffGitCached | wincmd x | resize 10

" 最後の編集位置にカーソルを復元
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" cmdline & statusline
" set cmdheight=1  " コマンドラインバッファ行数
" set laststatus=2 " ステータスラインを常に出力
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
