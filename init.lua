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
		{src = "https://github.com/vague-theme/vague.nvim"},
		{src = "https://github.com/stevearc/oil.nvim"},
		{src = "https://github.com/echasnovski/mini.pick"},
		{src = "https://github.com/neovim/nvim-lspconfig" },
		{src = "https://github.com/chomosuke/typst-preview.nvim"},
})

vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client:supports_method('textDocument/completion') then
						vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
				end
		end,
})
vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "oil".setup()

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

vim.lsp.enable({ "lua_ls", "svelte-language-server", "tinymist" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
