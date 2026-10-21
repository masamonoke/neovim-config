local capabilities = require('blink.cmp').get_lsp_capabilities()

require('blink.cmp').setup({
	completion = { documentation = { auto_show = true } },
	keymap = {
		['<TAB>'] = { 'accept', 'fallback' },
		['<C-j>'] = { 'snippet_forward', 'fallback' },
		['<C-k>'] = { 'snippet_backward', 'fallback' },
		['<A-j>'] = { 'select_next', 'fallback' },
		['<A-k>'] = { 'select_prev', 'fallback' }
	}
})

vim.lsp.config('clangd', {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		require("inlay-hints").on_attach(client, bufnr)
	end,
	documentation = { markdown = true, },
	cmd = {
		-- "/Users/masamonoke/dev/work/mpe-linter/llvm-project/build/bin/clangd",
		"clangd",
		"--header-insertion=never",
		"--background-index",
		"--suggest-missing-includes",
		"-j=8",
		"--inlay-hints=true",
		"--pch-storage=memory"
	},
})
vim.lsp.enable('clangd')

vim.lsp.config('ts_ls', {})
vim.lsp.enable('ts_ls')

vim.lsp.config('pyright', {})
vim.lsp.enable('pyright')

vim.lsp.config('bashls', {})
vim.lsp.enable('bashls')

vim.lsp.config('marksman', {})
vim.lsp.enable('marksman')

vim.lsp.config('gopls', {})
vim.lsp.enable({ 'gopls' })

vim.lsp.config('csharp-ls', {})
vim.lsp.enable('csharp-ls')

vim.lsp.config.rust_analyzer = {
	capabilities = capabilities,
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { "Cargo.toml", ".git" },
	single_file_support = true,
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = true,
			}
		}
	},
	before_init = function(init_params, config)
		-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
		if config.settings and config.settings['rust-analyzer'] then
			init_params.initializationOptions = config.settings['rust-analyzer']
		end
	end,
}
vim.lsp.enable("rust_analyzer")

vim.lsp.config["neocmake"] = {
	cmd = { "neocmakelsp", "stdio" },
	filetypes = { "cmake" },
	root_markers = { "CMakeLists.txt", "CMakePresets.json", ".git" },
	init_options = {
		format = {
			enable = true,
		},
		scan_cmake_in_package = true,
	},
}
vim.lsp.enable("neocmake")

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
			telemetry = { enable = false },
		},
	},
})
vim.lsp.enable('lua_ls')

local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "swift" },
	callback = function()
		local root_dir = vim.fs.dirname(vim.fs.find({
			"Package.swift",
			".git",
		}, { upward = true })[1])
		local client = vim.lsp.start({
			name = "sourcekit-lsp",
			cmd = { "sourcekit-lsp" },
			root_dir = root_dir,
		})
		if client ~= nil then
			vim.lsp.buf_attach_client(0, client)
		end
	end,
	group = swift_lsp,
})

vim.lsp.config("armls", {
	cmd = { "armls" },
	filetypes = { "asm", "s", "S" },
	settings = {
		armls = {
			diagnostics = {
				enable = false
			},
		},
	},
})
vim.lsp.enable("armls")
