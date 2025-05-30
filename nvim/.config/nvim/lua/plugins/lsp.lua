-- all kinds of LSP configuration

return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	lazy = false,
	-- },
	-- {
	-- 	"mason-org/mason-lspconfig.nvim",
	-- 	dependencies = {
	-- 		"mason-org/mason.nvim",
	-- 		"neovim/nvim-lspconfig",
	-- 	},
	-- 	opts = {
	-- 		automatic_enable = true,
	-- 	},
	-- },
	{
		"neovim/nvim-lspconfig",
		-- dependencies = {
		-- 	"williamboman/mason.nvim",
		-- 	"mason-org/mason-lspconfig.nvim",
		-- },
		config = function()
			vim.opt.signcolumn = "yes"

			local lspconfig_defaults = require('lspconfig').util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				'force',
				lspconfig_defaults.capabilities,
				require('cmp_nvim_lsp').default_capabilities()
			)

			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local opts = { buffer = event.buf }

					-- vim.keymap.set('n', '<leader>e', lua vim.lsp.buf.hover(), opts)
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
					vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
					vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
				end,
			})

			-- instead of using mason for LSPs, we do everything ourselves

			local lsp_cfg = require("lspconfig")

			-- all lsps that do not require additional setup
			local stock_lsps = {
				"jsonls",
				"clangd",
				"rust_analyzer",
				"ruff",
				"pyright",
				"verible",
				"r_language_server",
			}

			-- set up stock lsps
			for _, lsp in pairs(stock_lsps) do
				lsp_cfg[lsp].setup({})
			end

			-- lsp_cfg['rust_analyzer'].setup({})

			-- individual lsps
			lsp_cfg.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				}
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"micangl/cmp-vimtex",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip")

			-- ls.config.set_config {
			-- 	history = true,
			-- 	updateevents = "TextChanged,TextChangedI"
			-- }

			-- load default snippets / friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- load custom snippets
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = "./snippets"
			})

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "vimtex" },
					-- { name = "buffer" },
				},
				snippet = {
					expand = function(args)
						-- vim.snippet.expand(args.body)
						ls.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- confirm completion
					['<CR>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if ls.expandable() then
								ls.expand()
							else
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end),

					-- if cmp.visible() then
					-- 	if ls.expandable() then
					-- 		ls.expand()
					-- 	else
					-- 		cmp.confirm({
					-- 			select = false,
					-- 			behavior = cmp.ConfirmBehavior.Replace,
					-- 		})
					-- 	end
					-- else
					-- 	fallback()
					-- end
					-- scroll up and down
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = 'select' })
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = 'select' })
						else
							fallback()
						end
					end, { 'i', 's' }),

					-- jump forward and back
					['<C-l>'] = cmp.mapping(function(fallback)
						if ls.locally_jumpable(1) then
							ls.jump(1)
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<C-k>'] = cmp.mapping(function(fallback)
						if ls.locally_jumpable(-1) then
							ls.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),

					-- scroll docs
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
			})
		end,
	},
}
