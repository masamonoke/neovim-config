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
set guicursor=n-v-c:block,i:ver25
set foldmethod=syntax
set conceallevel=1

call plug#begin()
Plug 'akinsho/toggleterm.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'master' }
Plug 'NMAC427/guess-indent.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'lukas-reineke/virt-column.nvim'
Plug 'wnkz/monoglow.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
nnoremap <F4> :bp \| sp \| bn \| bd<CR>
nnoremap <C-p> <C-i>

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

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
require("toggleterm").setup({
	open_mapping = [[<F12>]],
	direction = "float",
})

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

vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

vim.api.nvim_set_keymap('n', '<C-c>', [[:let @+ = expand("%:p")<CR>]], {noremap = true, silent = true})

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-Up>",   ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-Up>",   ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })

vim.cmd("colorscheme monoglow")

require("ibl").setup()

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
EOF

noremap d "_d

vnoremap < <gv
vnoremap > >gv

highlight LspInlayHint guibg=#707772

lua require('guess-indent').setup {}
autocmd FileType markdown setlocal wrap

autocmd FileType markdown setlocal linebreak
