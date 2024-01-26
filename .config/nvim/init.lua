-- Install plugin manager
-- git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim

require("paq")({
	"savq/paq-nvim",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"rose-pine/neovim",
	"theprimeagen/harpoon",
	"echasnovski/mini.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"jose-elias-alvarez/null-ls.nvim",
})

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Bubble lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor management
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

-- Clipboard management
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessions<cr>")

vim.keymap.set("n", "gq", vim.lsp.buf.format)

vim.keymap.set("n", "<C-j>", ":cnext<cr>zz")
vim.keymap.set("n", "<C-k>", ":cprev<cr>zz")
-- vim.keymap.set("n", "<leader>j", ":lnext<cr>zz")
-- vim.keymap.set("n", "<leader>k", ":lprev<cr>zz")

vim.keymap.set("n", "S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", telescope.find_files)
vim.keymap.set("n", "<leader>/", telescope.live_grep)

require("nvim-treesitter.configs").setup({ highlight = { enable = true } })

require("rose-pine").setup({ dark_variant = "moon", disable_italics = true })
vim.cmd.colorscheme("rose-pine")

local nav_file = require("harpoon.ui").nav_file
vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<C-h>", function()
	nav_file(1)
end)
vim.keymap.set("n", "<C-t>", function()
	nav_file(2)
end)
vim.keymap.set("n", "<C-n>", function()
	nav_file(3)
end)
vim.keymap.set("n", "<C-s>", function()
	nav_file(4)
end)

require("mini.comment").setup()
require("mini.completion").setup({ lsp_completion = { source_func = "omnifunc", auto_setup = false } })
vim.keymap.set("i", "<tab>", [[pumvisible() ? "\<c-n>" : "\<tab>"]], { expr = true })
vim.keymap.set("i", "<s-tab>", [[pumvisible() ? "\<c-p>" : "\<s-tab>"]], { expr = true })

local keys = {
	["cr"] = vim.api.nvim_replace_termcodes("<cr>", true, true, true),
	["ctrl-y"] = vim.api.nvim_replace_termcodes("<c-y>", true, true, true),
	["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<c-y><cr>", true, true, true),
}
vim.keymap.set("i", "<cr>", function()
	if vim.fn.pumvisible() ~= 0 then
		return vim.fn.complete_info()["selected"] ~= 1 and keys["ctrl-y"] or keys["ctrl-y_cr"]
	else
		return keys["cr"]
	end
end, { expr = true })

local shared_lsp_options = {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	on_attach = function(_, bufnr)
		-- Use omnifunc for completions
		-- https://github.com/echasnovski/nvim/blob/487ce206d88412db5577435ba956fcf5a19d6302/lua/ec/configs/nvim-lspconfig.lua#L11-L26
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.MiniCompletion.completefunc_lsp")

		vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
		vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { buffer = bufnr })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
	end,
}

require("mason").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		local servers = {
			denols = { root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc") },
			tsserver = {
				single_file_support = false,
				root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "tsconfig.jsonc"),
			},
		}
		require("lspconfig")[server_name].setup(
			vim.tbl_deep_extend("force", servers[server_name] or {}, shared_lsp_options)
		)
	end,
})

vim.diagnostic.config({ signs = false, virtual_text = false })

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.deno_fmt.with({
			condition = function(utils)
				return utils.root_has_file({ "deno.json", "deno.jsonc" })
			end,
		}),
		require("null-ls").builtins.formatting.fish_indent,
		require("null-ls").builtins.formatting.goimports,
		require("null-ls").builtins.formatting.prettierd.with({
			condition = function(utils)
				return not utils.root_has_file({ "deno.json", "deno.jsonc" })
			end,
			extra_filetypes = { "astro", "svelte" },
		}),
		require("null-ls").builtins.formatting.stylua,
	},
})

vim.opt.guicursor = ""
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.breakindent = true
vim.opt.scrolloff = 5
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.pumheight = 5