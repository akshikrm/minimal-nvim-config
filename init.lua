vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("~/.vim/undodir")
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.updatetime = 50
vim.opt.cursorline = true

vim.opt.statusline = "%f%h%m%r%w  %= %y %l,%c | %P"

vim.opt.shortmess:append("c")
vim.opt.completeopt = { "popup", "menuone", "noinsert" }

vim.go.pumheight = 15

vim.g.mapleader = " "

local highlightGroup = vim.api.nvim_create_augroup("highlight-yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Hightlight when yanking (copying) text",
	group = highlightGroup,
	callback = function()
		vim.highlight.on_yank({ timeout = 80 })
	end,
})

-- navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the top window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the bottom window" })

vim.keymap.set("n", "n", "nzzzv", { desc = "center after next search match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "center after previous search match" })
vim.keymap.set("n", "fe", vim.cmd.Ex, { desc = "[F]ile [E]xplorer" })



-- packages
require("nvim-surround").setup({})
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "javascript", "json", "go" },
	highlight = { enable = true },
	indent = { enable = true },
})

require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})


require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})


require('rose-pine').setup({
	variant = "main",
	dim_inactive_windows = false,
	extend_background_behind_borders = true,
	styles = {
		bold = false,
		italic = false,
		transparency = true,
	},
	groups = {
		border = "muted",
		link = "iris",
		panel = "surface",

		error = "love",
		hint = "iris",
		info = "foam",
		note = "pine",
		todo = "rose",
		warn = "gold",

		git_add = "foam",
		git_change = "rose",
		git_delete = "love",
		git_dirty = "rose",
		git_ignore = "muted",
		git_merge = "iris",
		git_rename = "pine",
		git_stage = "iris",
		git_text = "rose",
		git_untracked = "subtle",

		h1 = "iris",
		h2 = "foam",
		h3 = "rose",
		h4 = "gold",
		h5 = "pine",
		h6 = "foam",
	},

})

vim.cmd("colorscheme rose-pine")


vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLSPConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		local keymap = vim.keymap

		opts.desc = "Go to definition"
		keymap.set("n", "gd", vim.lsp.buf.definition, opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "Go to implementation"
		keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		opts.desc = "Go to references"
		keymap.set("n", "gr", vim.lsp.buf.references, opts)

		opts.desc = "Code action"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "Rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Diagnostics"
		keymap.set("n", "<leader>ed", vim.diagnostic.open_float, opts)

		opts.desc = "Hover"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

		opts.desc = "Format Document"
		keymap.set("n", "<leader>fd", vim.lsp.buf.format, opts)
	end,
})


vim.lsp.enable({
	"lua_ls",
	"vtsls",
})
