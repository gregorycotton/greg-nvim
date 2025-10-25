vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.opt.winborder = "rounded"
vim.opt.keymodel = 'startsel,stopsel'
vim.opt.clipboard = 'unnamedplus'

vim.keymap.set('v', '<D-c>', '"+y<Esc>')
vim.keymap.set('v', '<D-x>', '"+d<Esc>')
vim.keymap.set('n', '<D-v>', '"+P')
vim.keymap.set('i', '<D-v>', '<Esc>"+Pa')
vim.keymap.set('v', '<BS>', '"+d<Esc>')

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>t', ':bel sp | terminal<CR>')

vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

local on_attach = function(client, bufnr)
	if client:supports_method('textDocument/completion') then
		vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
	end

	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
end

vim.lsp.config("lua_ls", {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
			diagnostics = {
				globals = {
					'vim' -- recognize global vim var
				}
			},
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
})

local all_servers = {
	"lua_ls",
	"ts_ls",
	"pyright",
	"rust_analyzer",
	"clangd"
}

for _, server_name in ipairs(all_servers) do
	vim.lsp.enable(server_name)
end

vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "oil".setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
