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

call plug#begin()
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" Plug 'nvim-tree/nvim-web-devicons'
Plug 'itchyny/vim-gitbranch'
Plug 'akinsho/toggleterm.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'ryanoasis/vim-devicons'
" Plug 'folke/todo-comments.nvim'
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
call plug#end()

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
nnoremap <F4> :bp \| sp \| bn \| bd<CR>
nnoremap <C-p> <C-i>

highlight CocErrorFloat ctermfg=204 guifg=#ffffff

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

autocmd TextChanged,TextChangedI <buffer> silent write

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <F1> :Telescope buffers <CR>
nnoremap <F2> :Telescope find_files<CR>
nnoremap <F3> :Telescope live_grep<CR>
nnoremap <F5> :Telescope current_buffer_fuzzy_find<CR>

set keywordprg=:call\ CocActionAsync('doHover')
nnoremap <C-]> :call CocActionAsync('jumpDefinition') <CR>
nnoremap <silent> <leader>a :call CocActionAsync('codeAction')<CR>
verbose nmap <leader>rn <Plug>(coc-rename)
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
hi CocInlayHint guibg=#707772
nnoremap <silent> <F10> :CocList diagnostics --current<CR>
augroup cpp_coc_settings
  autocmd!
  autocmd FileType cpp let g:coc_user_config = {
    \ "clangd": {
    \   "fallbackFlags": ["-std=c++20"]
    \ }
    \ }
augroup END

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

nnoremap <C-n> :NvimTreeToggle <CR>

set undofile
set undodir=~/.vim/undo

nnoremap <leader>h :HopWord<CR>

au BufNewFile,BufRead *.wgsl set filetype=wgsl

vnoremap < <gv
vnoremap > >gv

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

if vim.fn.has('nvim-0.11') == 1 then
	vim.api.nvim_set_hl(0, "StatusLine", {reverse = false})
	vim.api.nvim_set_hl(0, "StatusLineNC", {reverse = false})
end
require('lualine').setup()

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

require("nvim-autopairs").setup {}

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
	statuscolumn = { enabled = true }
})

require("auto-save").setup {
	execution_message = {
		message = function()
			return ("Saved buffer")
		end,
	}
}
EOF
