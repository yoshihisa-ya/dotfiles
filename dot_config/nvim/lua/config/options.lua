local opt = vim.opt

vim.g.mapleader = ","
vim.g.maplocalleader = "_"
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.Gtags_Auto_Map = 1

opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.cursorline = true
opt.cursorcolumn = false
opt.title = true
opt.termguicolors = true
opt.winblend = 0
opt.pumblend = 10
opt.mouse = "a"

opt.backup = false
opt.swapfile = false
opt.hidden = true
opt.autowrite = true
opt.autoread = true
opt.backupcopy = "yes"

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 0
opt.shiftwidth = 2
opt.autoindent = true
opt.cindent = true
opt.showmatch = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true

opt.list = true
opt.listchars = {
	tab = "^_",
	trail = "_",
	space = "⋅",
	eol = "↴",
}

opt.modeline = true

-- Docker Compose と Ansible のファイルに複合 filetype を付ける (docker_compose_language_service と ansiblels を起動するため)
vim.filetype.add({
	filename = {
		["compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["docker-compose.yml"] = "yaml.docker-compose",
	},
	pattern = {
		-- roles/<role>/tasks/main.yml など (リポジトリ直下と ansible/ の下の両方)
		[".*/roles/[^/]+/tasks/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/[^/]+/handlers/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/[^/]+/defaults/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/[^/]+/vars/.*%.ya?ml"] = "yaml.ansible",
		[".*/roles/[^/]+/meta/.*%.ya?ml"] = "yaml.ansible",
		-- ansible/ ディレクトリの下 (ansible/site.yml、ansible/group_vars/ など)
		[".*/ansible/.*%.ya?ml"] = "yaml.ansible",
		-- 名前に ansible や playbook を含むリポジトリの直下 (site.yml など)。.github/ などの下は対象外
		[".*/[^/]*[Aa]nsible[^/]*/[^/]+%.ya?ml"] = "yaml.ansible",
		[".*/[^/]*[Pp]laybook[^/]*/[^/]+%.ya?ml"] = "yaml.ansible",
	},
})
