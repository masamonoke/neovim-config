vim.lsp.inlay_hint.enable(true)

require('blink.cmp').setup({
	completion = { documentation = { auto_show = true } },
	keymap = {
		['<TAB>'] = { 'accept', 'fallback' },
		['<C-j>'] = { 'snippet_forward', 'fallback' },
		['<C-k>'] = { 'snippet_backward', 'fallback' },
		['<A-j>'] = { 'select_next', 'fallback' },
		['<A-k>'] = { 'select_prev', 'fallback' },
		["<A-Space>"] = {
			function(cmp)
				if cmp.is_visible() then
					cmp.hide()
				else
					cmp.show()
				end
				return true
			end,
		},
	}
})
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('clangd', {
	capabilities = capabilities,
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

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html', 'templ' },
  root_markers = { 'package.json', '.git' },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
  },
  capabilities = capabilities,
})
vim.lsp.enable('html')

vim.lsp.config.asm_lsp = {
  cmd = { "asm-lsp" },
  filetypes = { "asm" },
  root_markers = { ".asm-lsp.toml", ".git" },
}
vim.lsp.enable("asm_lsp")
