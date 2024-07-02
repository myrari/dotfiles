-- normal options
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.cc = "80"

--vim.cmd("syntax on")
vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")

-- reassign leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- remap move keys
vim.keymap.set({"n", "v", "o"}, 'j', '<Left>')
vim.keymap.set({"n", "v", "o"}, 'k', '<Down>')
vim.keymap.set({"n", "v", "o"}, 'l', '<Up>')
vim.keymap.set({"n", "v", "o"}, ';', '<Right>')

-- faster scrolling
vim.keymap.set({"n", "v", "o"}, 'K', '5<Down>')
vim.keymap.set({"n", "v", "o"}, 'L', '5<Up>')

-- window switch remap
vim.keymap.set({"n", "v", "o"}, '<C-w><C-j>', '<C-w>h')
vim.keymap.set({"n", "v", "o"}, '<C-w><C-k>', '<C-w>j')
vim.keymap.set({"n", "v", "o"}, '<C-w><C-l>', '<C-w>k')
vim.keymap.set({"n", "v", "o"}, '<C-w><C-;>', '<C-w>l')
-- semicolon is different. idk why. it just randomly stopped working

-- faster window creation, swapped h/v cuz it makes more sense to me
vim.keymap.set("n", "<leader>h", ":wincmd v<cr>:wincmd l<cr>")
vim.keymap.set("n", "<leader>v", ":wincmd s<cr>:wincmd j<cr>")

-- terminal keybinds
vim.keymap.set("n", "<leader>th", ":wincmd v<cr>:wincmd l<cr>:term<cr>i")
vim.keymap.set("n", "<leader>tv", ":wincmd s<cr>:wincmd j<cr>:term<cr>i")
vim.keymap.set("n", "<leader>tt", ":term<cr>i")
vim.keymap.set("t", "fj", "<C-\\><C-n>")

-- same command to exit other modes
vim.keymap.set({"i", "v", "o"}, "fj", "<ESC>")

-- faster buffer switching
vim.keymap.set("n", "<leader>b", ":b ")

-- use system clipboard
vim.cmd("set clipboard=unnamedplus")

-- initialize lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({{import = "plugins"}})

-- enable color scheme
require("onedark").load()

-- enable & configure telescope file browser
require("telescope").load_extension "file_browser"
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

-- if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) then
-- 	vim.defer_fn(
-- 		function ()
-- 			vim.cmd("Telescope file_browser path=%:p:h select_buffer=true")
-- 		end,
-- 		0
-- 	)
-- end

if vim.fn.argc() == 1 and vim.fn.argv(0) == "t" then
	vim.cmd(":term")
end

-- configure lsp-zero
local lsp_zero = require("lsp-zero")
lsp_zero.extend_lspconfig()

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

-- custom flags for certain lsps
local lsp_flags = {}
lsp_flags["rust-analyzer"] = "features debug"

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({
				flags = lsp_flags[server_name],
			})
		end,
	}
})

-- enable snippets and configure keybinds
require("luasnip.loaders.from_vscode").lazy_load()

local ls = require("luasnip")

ls.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI"
}

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping(function(fallback)
        	if cmp.visible() then
            	if ls.expandable() then
                	ls.expand()
            	else
                	cmp.confirm({
                    	select = true,
                	})
            	end
        	else
            	fallback()
        	end
    	end),

	    ["<Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
	        cmp.select_next_item()
	      elseif ls.locally_jumpable(1) then
	        ls.jump(1)
	      else
	        fallback()
	      end
	    end, { "i", "s" }),

	    ["<S-Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
	        cmp.select_prev_item()
	      elseif ls.locally_jumpable(-1) then
	        ls.jump(-1)
	      else
	        fallback()
	      end
	    end, { "i", "s" }),

		-- navigate snipper placeholders
		['<C-l>'] = cmp_action.luasnip_jump_forward(),
    	['<C-k>'] = cmp_action.luasnip_jump_backward(),
	}),
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end
	}
})

-- custom project command
vim.api.nvim_create_user_command("Projects", "Telescope neovim-project discover", {})
vim.api.nvim_create_user_command("P", "Projects", {})
vim.keymap.set("n", "<leader>p", ":P<CR>");

