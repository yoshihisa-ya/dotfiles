local opt = vim.opt

vim.g.mapleader            = ","
vim.g.maplocalleader       = '_'
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.Gtags_Auto_Map       = 1

opt.number         = true
opt.relativenumber = true
opt.ruler          = true
opt.cursorline     = true
opt.cursorcolumn   = false
opt.title          = true
opt.termguicolors  = true
opt.winblend       = 0
opt.pumblend       = 10
opt.mouse          = "a"

opt.backup     = false
opt.swapfile   = false
opt.hidden     = true
opt.autowrite  = true
opt.autoread   = true
opt.backupcopy = "yes"

opt.expandtab   = true
opt.tabstop     = 2
opt.softtabstop = 0
opt.shiftwidth  = 2
opt.autoindent  = true
opt.cindent     = true
opt.showmatch   = true

opt.ignorecase = true
opt.smartcase  = true
opt.incsearch  = true
opt.hlsearch   = true
opt.wrapscan   = true

opt.list = true
opt.listchars = {
  tab   = "^_",
  trail = "_",
  space    = "⋅",
  eol      = "↴",
}

opt.modeline = true
