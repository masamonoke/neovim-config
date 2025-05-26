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
set cursorline
set filetype=on
set formatprg=clang-format
set guicursor=n-v-c:block,i:ver25

call plug#begin()
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'

	Plug 'windwp/nvim-autopairs'
	Plug 'tpope/vim-commentary'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'karb94/neoscroll.nvim'
	Plug 'itchyny/vim-gitbranch'
	Plug 'akinsho/toggleterm.nvim'
	Plug 'ellisonleao/gruvbox.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'yamatsum/nvim-cursorline'
	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'ryanoasis/vim-devicons'
	Plug 'folke/todo-comments.nvim'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'pocco81/auto-save.nvim'
	Plug 'rmagatti/auto-session'
	Plug 'nvim-treesitter/nvim-treesitter-context'
	Plug 'petertriho/nvim-scrollbar'
	Plug 'm-demare/hlargs.nvim'
	Plug 'HiPhish/rainbow-delimiters.nvim'
	Plug 'MysticalDevil/inlay-hints.nvim'
	Plug 'nvim-tree/nvim-tree.lua'
	Plug 'Badhi/nvim-treesitter-cpp-tools'
	Plug 'tveskag/nvim-blame-line'
	Plug 'isak102/telescope-git-file-history.nvim'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'kevinhwang91/promise-async'
	Plug 'kevinhwang91/nvim-ufo'
	Plug 'mawkler/modicator.nvim'
	Plug 'smoka7/hop.nvim'
	Plug 'akinsho/bufferline.nvim'
	Plug 'lukas-reineke/virt-column.nvim'
	Plug 'folke/noice.nvim'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'max397574/better-escape.nvim'
	Plug 'madskjeldgaard/cheeky-snippets.nvim'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'sphamba/smear-cursor.nvim'
	Plug 'folke/snacks.nvim'
	Plug 'rachartier/tiny-inline-diagnostic.nvim'
	Plug 'echasnovski/mini.indentscope'
	Plug 'rachartier/tiny-glimmer.nvim'
	Plug 'nullromo/go-up.nvim'
	Plug 'epwalsh/pomo.nvim'
	Plug 'NStefan002/visual-surround.nvim'
	Plug 'mrcjkb/haskell-tools.nvim'
	Plug 'MeanderingProgrammer/render-markdown.nvim'
	Plug 'tzachar/local-highlight.nvim'
	Plug 'jackplus-xyz/player-one.nvim'
	Plug 'tris203/precognition.nvim'
	Plug 'David-Kunz/gen.nvim'
	Plug 'slugbyte/lackluster.nvim'
	Plug 'tzachar/highlight-undo.nvim'
call plug#end()

lua require('config')

imap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

au BufNewFile,BufRead *.lua setfiletype lua

lua << EOF
	local cmp = require'cmp'

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			end,
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' }, -- For vsnip users.
		}, {
			{ name = 'buffer' },
		}),
	})

	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	require'lspconfig'.clangd.setup {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			require("inlay-hints").on_attach(client, bufnr)
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

	-- Show line diagnostics automatically in hover window
	vim.o.updatetime = 250
	vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
EOF

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
nnoremap <F4> :bp \| sp \| bn \| bd<CR>
nnoremap <C-p> <C-i>

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

let g:indentLine_setColors = 0

autocmd TextChanged,TextChangedI <buffer> silent write

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <F1> :Telescope buffers <CR>
nnoremap <F2> :Telescope find_files<CR>
nnoremap <F3> :Telescope live_grep<CR>
nnoremap <F5> :Telescope current_buffer_fuzzy_find<CR>
nnoremap <F10> :Telescope bookmarks list<CR>
nnoremap <F11> :Telescope git_file_history<CR>

autocmd FileType html setlocal sw=2 ts=2
autocmd FileType vue setlocal sw=2 ts=2
autocmd FileType r setlocal sw=1 ts=1 expandtab
autocmd FileType xml setlocal sw=2 ts=2

augroup VimHelp
  autocmd!
  autocmd Filetype vim,help setlocal keywordprg=:help
augroup END

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

let g:pydoc_open_cmd = 'tabnew'

set foldmethod=manual

autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

noremap d "_d

vnoremap < <gv
vnoremap > >gv

let g:indent_blankline_show_current_context = v:true

let g:highlighturl_guifg = '#DB7093'

nnoremap <C-n> :NvimTreeToggle <CR>

set undofile
set undodir=~/.vim/undo

nnoremap <leader>h :HopWord<CR>

set lazyredraw

highlight LspInlayHint guibg=#707772

if exists("g:neovide")
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		nnoremap <D-s> :w<CR>
		vnoremap <D-c> "+y
		nnoremap <D-v> "+P
		vnoremap <D-v> "+P
		cnoremap <D-v> <C-R>+
		inoremap <D-v> <C-R>+
	else
		vnoremap <silent> <sc-c> "+P
		cnoremap <silent> <sc-v> <C-o>l<C-o>"+<C-o>P<C-o>l
		tnoremap <silent> <sc-v> <C-\><C-n>"+Pi
		inoremap <silent> <sc-v> <C-R>+
		nnoremap <silent> <sc-v> "+P
	endif

	let g:neovide_fullscreen=v:true
else
	lua require('smear_cursor').enabled = true
endif

lua << EOF
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
EOF
