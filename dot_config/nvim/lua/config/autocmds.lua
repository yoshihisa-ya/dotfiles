local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local highlight_group = augroup("highlightIdeographicSpace", { clear = true })
autocmd("ColorScheme", {
  group   = highlight_group,
  pattern = "*",
  command = "highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen",
})
autocmd({ "VimEnter", "WinEnter" }, {
  group   = highlight_group,
  pattern = "*",
  command = [[match IdeographicSpace /　/]],
})

autocmd("BufReadPost", {
  pattern  = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount and not vim.bo.filetype:find("commit") then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

autocmd("FileType", {
  pattern  = "gitcommit",
  command  = "DiffGitCached | wincmd x | resize 10",
})

autocmd("FileType", {
  pattern  = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

local indent_group = augroup("foldmethod", { clear = true })
autocmd("FileType", {
  group    = indent_group,
  pattern  = "sh",
  callback = function()
    vim.opt_local.expandtab  = true
    vim.opt_local.tabstop    = 4
    vim.opt_local.shiftwidth = 4
  end,
})
autocmd("FileType", {
  group    = indent_group,
  pattern  = "go",
  callback = function()
    vim.opt_local.expandtab  = false
    vim.opt_local.tabstop    = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.diagnostic.config({
  virtual_lines  = true,
  virtual_text   = false,
  signs          = true,
  update_in_insert = false,
  severity_sort  = true,
})
