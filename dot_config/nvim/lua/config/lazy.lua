local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
		opts = {
			transparent = true,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "material",
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					colored = true,
					globalstatus = true,
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"bash",
					"c_sharp",
					"git_config",
					"git_rebase",
					"html",
					"jq",
					"json",
					"make",
					"markdown",
					"muttrc",
					"printf",
					"promql",
					"python",
					"rst",
					"ssh_config",
					"strace",
					"systemtap",
					"terraform",
					"toml",
					"xml",
					"yaml",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"nvim-telescope/telescope-frecency.nvim",
				dependencies = {
					"kkharji/sqlite.lua",
					"nvim-tree/nvim-web-devicons",
				},
			},
		},
		config = function()
			local builtin = require("telescope.builtin")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("frecency")
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fF", function()
				builtin.find_files({ hidden = true, no_ignore = true })
			end, {})
			vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fr", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fm", builtin.man_pages, {})
			vim.keymap.set("n", "<leader>fo", function()
				require("telescope").extensions.frecency.frecency()
			end, {})
			vim.keymap.set("n", "<leader>f<CR>", builtin.resume, {})
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
			vim.keymap.set("n", "<leader>gt", builtin.git_status, {})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = [[<c-\>]],
		},
		keys = {
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				numbers = "none",
				indicator = {
					style = "none",
				},
				diagnostics = "nvim_lsp",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text_pos = "right_align",
				delay = 100,
			},
		},
		keys = {
			{ "<leader>gd", function() require("gitsigns").diffthis() end,       desc = "Gitsigns diff this" },
			{ "<leader>gl", function() require("gitsigns").blame_line() end,      desc = "Gitsigns blame line" },
			{ "<leader>gs", function() require("gitsigns").stage_hunk() end,      desc = "Gitsigns stage hunk" },
			{ "<leader>gS", function() require("gitsigns").stage_buffer() end,    desc = "Gitsigns stage buffer" },
			{ "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = "Gitsigns undo stage hunk" },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			local on_attach = function(client, bufnr)
				vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				map("gD",        vim.lsp.buf.declaration,             "Go to declaration")
				map("gd",        vim.lsp.buf.definition,              "Go to definition")
				map("K",         vim.lsp.buf.hover,                   "Hover documentation")
				map("gi",        vim.lsp.buf.implementation,          "Go to implementation")
				map("<C-k>",     vim.lsp.buf.signature_help,          "Signature help")
				map("<space>wa", vim.lsp.buf.add_workspace_folder,    "Add workspace folder")
				map("<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
				map("<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,                                                   "List workspace folders")
				map("<space>D",  vim.lsp.buf.type_definition,         "Type definition")
				map("<space>rn", vim.lsp.buf.rename,                  "Rename symbol")
				map("<space>ca", vim.lsp.buf.code_action,             "Code action")
				map("gr",        vim.lsp.buf.references,              "References")
			end
			require("mason-lspconfig").setup({
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
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							on_attach = on_attach,
							capabilities = require("blink.cmp").get_lsp_capabilities(),
						})
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		-- :MasonInstall shfmt stylua
		event = "BufWritePre",
		keys = {
			{
				"<space>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				sh = { "shfmt" },
				lua = { "stylua" },
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "4" },
				},
			},
			format_on_save = {
				lsp_fallback = true,
			},
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = true, window = { winblend = 10 } },
				menu = { winblend = 10 },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"j-hui/fidget.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"vim-skk/skkeleton",
		dependencies = "vim-denops/denops.vim",
		config = function()
			vim.fn["skkeleton#config"]({
				globalDictionaries = { "/usr/share/skk/SKK-JISYO.L" },
			})
			vim.fn["skkeleton#initialize"]()
		end,
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
		"kevinhwang91/nvim-hlslens",
		config = true,
	},
	{ "vim-scripts/gtags.vim" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					enabled = true,
					jump_labels = true,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"vimwiki/vimwiki",
		keys = { "<leader>ww", "<leader>wt" },
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/notes/wiki",
					syntax = "markdown",
					ext = "md",
				},
			}
		end,
	},
	{
		"tools-life/taskwiki",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
		},
	},
	{
		"pwntester/octo.nvim",
		cmd = "Octo",
		opts = {
			-- or "fzf-lua" or "snacks" or "default"
			picker = "telescope",
			-- bare Octo command opens picker of commands
			enable_builtin = true,
		},
		keys = {
			{
				"<leader>oi",
				"<CMD>Octo issue list<CR>",
				desc = "List GitHub Issues",
			},
			{
				"<leader>op",
				"<CMD>Octo pr list<CR>",
				desc = "List GitHub PullRequests",
			},
			{
				"<leader>od",
				"<CMD>Octo discussion list<CR>",
				desc = "List GitHub Discussions",
			},
			{
				"<leader>on",
				"<CMD>Octo notification list<CR>",
				desc = "List GitHub Notifications",
			},
			{
				"<leader>os",
				function()
					require("octo.utils").create_base_search_command({ include_current_repo = true })
				end,
				desc = "Search GitHub",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- OR "ibhagwan/fzf-lua",
			-- OR "folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
}, {
	rocks = { enabled = false },
})
