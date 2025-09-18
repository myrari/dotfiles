-- normal options
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.cc = "80"

-- remap leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- remap move keys
vim.keymap.set({ "n", "v", "o" }, "j", "<Left>")
vim.keymap.set({ "n", "v", "o" }, "k", "<Down>")
vim.keymap.set({ "n", "v", "o" }, "l", "<Up>")
vim.keymap.set({ "n", "v", "o" }, ";", "<Right>")

-- faster scrolling
vim.keymap.set({ "n", "v", "o" }, 'K', '5<Down>')
vim.keymap.set({ "n", "v", "o" }, 'L', '5<Up>')

-- window switch remap
vim.keymap.set({ "n", "v", "o" }, '<C-w><C-j>', '<C-w>h')
vim.keymap.set({ "n", "v", "o" }, '<C-w><C-k>', '<C-w>j')
vim.keymap.set({ "n", "v", "o" }, '<C-w><C-l>', '<C-w>k')
vim.keymap.set({ "n", "v", "o" }, '<C-w><C-;>', '<C-w>l')

-- custom text object for whole buffer
vim.keymap.set({ "x", "o" }, "ae", ':<C-u>normal! mzggVG<CR>`z')

-- shortcuts for splitting
vim.keymap.set("n", "<leader>v", ":split<CR><C-w>j")
vim.keymap.set("n", "<leader>h", ":vsplit<CR><C-w>l")

-- remap exit command to fj
vim.keymap.set({ "i", "v", "o" }, "fj", "<ESC>")
vim.keymap.set("t", "fj", "<C-\\><C-n>")

-- toggle spell check
vim.keymap.set({ "n", "v", "o" }, "<localleader>ss", function()
	if vim.o.spell then
		print("spell check off")
		vim.o.spell = false
	else
		print("spell check on")
		vim.o.spell = true
	end
end)

-- use system clipboard
vim.cmd("set clipboard=unnamedplus")

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
vim.opt.termguicolors = true
vim.opt.guicursor = ""

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	rocks = { enabled = false },
})
