if $TERM_PROGRAM != "Apple_Terminal"
    set termguicolors
endif
syntax on
set ts=4 sw=4
set nostartofline
set number
set mouse=a
set noswapfile
set nowrap
set hlsearch
set clipboard+=unnamedplus
set noshowmode
set filetype=on
set cursorline
set formatprg=clang-format
set guicursor=n-v-c:block,i:ver25
set foldmethod=syntax
set conceallevel=2

call plug#begin()
Plug 'm4xshen/autoclose.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'itchyny/vim-gitbranch'
Plug 'akinsho/toggleterm.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'folke/todo-comments.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'smoka7/hop.nvim'
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'NMAC427/guess-indent.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'lukas-reineke/virt-column.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'folke/snacks.nvim'
Plug 'pocco81/auto-save.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-zh/whitespace.nvim'
Plug 'nvim-zh/colorful-winsep.nvim'
Plug 'echasnovski/mini.indentscope'
Plug 'rmagatti/goto-preview'
Plug 'epwalsh/obsidian.nvim'

Plug 'mrcjkb/haskell-tools.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'Saghen/blink.cmp'
Plug 'folke/trouble.nvim'
Plug 'MysticalDevil/inlay-hints.nvim'
Plug 'mrcjkb/rustaceanvim'
call plug#end()

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
nnoremap <F4> :bp \| sp \| bn \| bd<CR>
nnoremap <C-p> <C-i>

highlight CocErrorFloat ctermfg=204 guifg=#ffffff

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <F1> :Telescope buffers <CR>
nnoremap <F2> :Telescope find_files<CR>
nnoremap <F3> :Telescope live_grep<CR>
nnoremap <F5> :Telescope current_buffer_fuzzy_find<CR>

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

nnoremap <C-n> :NvimTreeToggle <CR>

set undofile
set undodir=~/.vim/undo

nnoremap <leader>h :HopWord<CR>

au BufNewFile,BufRead *.wgsl set filetype=wgsl

lua << EOF
require("nvim-tree").setup({
	view = {
		width = 70,
	},
	renderer = {
		indent_markers = {
			enable = true
		}
	}
})

require("telescope").setup {
	defaults = {
		preview = {
			treesitter = false
		}
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
				-- your custom insert mode mappings
				["<Tab>"] = false,
				["<S-Tab>"] = false
				},
				["n"] = {
				-- your custom normal mode mappings
				},
			},
		},
	},
}
require("telescope").load_extension "file_browser"
vim.api.nvim_set_keymap(
	"n",
	"<F6>",
	":Telescope file_browser path=%:p:h select_buffer=true<CR>",
	{ noremap = false }
)
require('telescope').load_extension('fzf')

require("noice").setup({
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	}
})

require("autoclose").setup()

require("toggleterm").setup({
	open_mapping = [[<F12>]],
	direction = "float",
})

require("virt-column").setup({
})

require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

require('gitsigns').setup {
	signs = {
		add          = { text = '│' },
		change       = { text = '│' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆'},
	},
	signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
	numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
}

require("gruvbox").setup({
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	undercurl = true,
	underline = true,
	inverse = true,
	contrast = "soft"
})
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require('ufo').setup()
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require("snacks").setup({
	quickfile = { enabled = true },
	statuscolumn = { enabled = true },
	bufdelete = { enabled = true }
})

require("auto-save").setup {
	execution_message = {
		message = function()
			return ("Saved buffer")
		end,
	}
}

require("todo-comments").setup {}

require('neoscroll').setup({
	-- All these keys will be mapped to their corresponding default scrolling animation
	mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
		'<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
	hide_cursor = true,          -- Hide cursor while scrolling
	stop_eof = false,             -- Stop at <EOF> when scrolling downwards
	respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function = nil,       -- Default easing function
	pre_hook = function()
		local line_count = vim.api.nvim_buf_line_count(0) if line_count > 1000 then vim.g.neoscroll_performance_mode = true else vim.g.neoscroll_performance_mode = false end
	end,
})

local bufferline = require('bufferline')
bufferline.setup({
	options = {
		separator_style = "slant",
		buffer_close_icon = '󰅖',
		modified_icon = '● ',
		close_icon = ' ',
		left_trunc_marker = ' ',
		right_trunc_marker = ' ',
		truncate_names = false,
		color_icons = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = {'close'}
		},
		diagnostics = "coc",
		always_show_bufferline = false
	}
})

require('nvim-cursorline').setup {
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = true },
	},
	cursorline = {
		enable = true,
		timeout = 100,
		number = false,
	},
}

require('colorful-winsep').setup()

require'nvim-treesitter.configs'.setup {
	ensure_installed = { "lua", "vim" },
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

vim.api.nvim_set_hl(0, "StatusLine", {reverse = false})
vim.api.nvim_set_hl(0, "StatusLineNC", {reverse = false})
require('lualine').setup()

require('mini.indentscope').setup({
	symbol = '┃'
})

vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

vim.api.nvim_set_keymap('n', '<C-c>', [[:let @+ = expand("%:p")<CR>]], {noremap = true, silent = true})

local capabilities = require('blink.cmp').get_lsp_capabilities()

require('blink.cmp').setup({
	completion = { documentation = { auto_show = true } },
	keymap = {
		['<TAB>'] = { 'accept', 'fallback' },
		['<C-j>'] = { 'snippet_forward', 'fallback' },
		['<C-k>'] = { 'snippet_backward', 'fallback' }
	}
})

require'lspconfig'.clangd.setup {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		require("inlay-hints").on_attach(client, bufnr)
		-- client.server_capabilities.semanticTokensProvider = nil
	end,
	cmd = {
		"clangd",
		"--header-insertion=never",
		"--background-index",
		"--suggest-missing-includes",
		"-j=8",
		"--clang-tidy",
		"--inlay-hints=true",
		"--pch-storage=memory"
	},
}

require'lspconfig'.glsl_analyzer.setup {}

require'lspconfig'.ts_ls.setup {}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.wgsl",
	callback = function()
		vim.bo.filetype = "wgsl"
	end,
})

require'lspconfig'.wgsl_analyzer.setup({})

require'lspconfig'.pyright.setup({})

require 'lspconfig'.bashls.setup {}

require 'lspconfig'.marksman.setup {}

require("inlay-hints").setup()

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require("trouble").setup{}
vim.keymap.set('n', '<F10>', '<cmd>Trouble diagnostics toggle<CR>')
vim.keymap.set('n', '<F11>', '<cmd>Trouble lsp_references<CR>')

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename variable' })

require('goto-preview').setup()
vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})

require("obsidian").setup({
	workspaces = {
		{
			name = "notes",
			path = "/home/mrudakov/Work/notes/base",
		},
	},
})
EOF

noremap d "_d

vnoremap < <gv
vnoremap > >gv

highlight LspInlayHint guibg=#707772

lua require('guess-indent').setup {}
