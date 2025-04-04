return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Auto-install LSP servers
			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"rust_analyzer",
					"ts_ls",
					"html",
					"cssls",
					"jsonls",
					"yamlls",
					"bashls",
					"clangd",
					"gopls",
					"tsserver",
					"tailwindcss",
					"eslint",
					"prismals",
					"graphql",
					"astro",
					"svelte",
					"angularls",
					"emmet_ls",
					"volar",
					"vuels",
				},
			})

			-- Common LSP settings
			local common_setup = {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					-- Enable completion triggered by <c-x><c-o>
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

					-- Mappings
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, bufopts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, bufopts)
				end,
			}

			-- Language-specific configurations
			lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", common_setup, {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			}))

			-- TypeScript/JavaScript configuration
			lspconfig.ts_ls.setup(vim.tbl_deep_extend("force", common_setup, {
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			}))

			-- Setup remaining language servers
			lspconfig.pyright.setup(common_setup)
			lspconfig.rust_analyzer.setup(common_setup)
			lspconfig.html.setup(common_setup)
			lspconfig.cssls.setup(common_setup)
			lspconfig.jsonls.setup(common_setup)
			lspconfig.yamlls.setup(common_setup)
			lspconfig.bashls.setup(common_setup)
			lspconfig.clangd.setup(common_setup)
			lspconfig.gopls.setup(common_setup)
			lspconfig.tailwindcss.setup(common_setup)
			lspconfig.eslint.setup(common_setup)
			lspconfig.prismals.setup(common_setup)
			lspconfig.graphql.setup(common_setup)
			lspconfig.astro.setup(common_setup)
			lspconfig.svelte.setup(common_setup)
			lspconfig.angularls.setup(common_setup)
			lspconfig.emmet_ls.setup(common_setup)
			lspconfig.volar.setup(common_setup)
			lspconfig.vuels.setup(common_setup)

			-- Diagnostic configuration
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
			})

			-- Diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
} 