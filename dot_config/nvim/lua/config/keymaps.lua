local map = vim.keymap.set

map("n", "<C-n>", "<cmd>cnext<CR>")
map("n", "<C-p>", "<cmd>cprevious<CR>")
map("n", "<leader>a", "<cmd>cclose<CR>")
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "ZZ", "<Nop>")
map("n", "<ESC><ESC>", "<cmd>nohlsearch<CR>")

map("i", "<C-j>", "<Plug>(skkeleton-enable)", { remap = true })
map("c", "<C-j>", "<Plug>(skkeleton-enable)", { remap = true })

map("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostic: open float" })
map("n", "[d",       vim.diagnostic.goto_prev,  { desc = "Diagnostic: previous" })
map("n", "]d",       vim.diagnostic.goto_next,  { desc = "Diagnostic: next" })
map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostic: set loclist" })
