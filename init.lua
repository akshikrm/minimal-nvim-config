vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME" .. "/.vim/undodir")
vim.opt.undofile = true

vim.opt.termguicolors = false
vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.updatetime = 50
vim.opt.cursorline = true

vim.opt.statusline = "%f%h%m%r%w  %= %y %l,%c | %P"

vim.opt.shortmess:append("c")
vim.opt.completeopt = { "menu", "menuone", "noselect" }

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

vim.keymap.set("n", "fe", vim.cmd.Ex, { desc = "[F]ile [E]xplorer" })


-- packages
require("nvim-surround").setup({})
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "javascript", "json", "go" },
	highlight = { enable = true },
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
	"ts_ls",
})
