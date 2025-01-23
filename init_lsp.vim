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
	Plug 'ARM9/arm-syntax-vim'
	Plug 'ellisonleao/gruvbox.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'xiyaowong/nvim-transparent'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'yamatsum/nvim-cursorline'
	Plug 'shime/vim-livedown'
	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'ryanoasis/vim-devicons'
	Plug 'folke/todo-comments.nvim'
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
	Plug 'sindrets/diffview.nvim'
	Plug 'pocco81/auto-save.nvim'
	Plug 'rmagatti/auto-session'
	Plug 'nvim-treesitter/nvim-treesitter-context'
	Plug 'petertriho/nvim-scrollbar'
	Plug 'm-demare/hlargs.nvim'
	Plug 'HiPhish/rainbow-delimiters.nvim'
	Plug 'MysticalDevil/inlay-hints.nvim'
	Plug 'nvim-tree/nvim-tree.lua'
	Plug 'Badhi/nvim-treesitter-cpp-tools'
	Plug 'monkoose/neocodeium'
	Plug 'tveskag/nvim-blame-line'
	Plug 'tomasky/bookmarks.nvim'
	Plug 'isak102/telescope-git-file-history.nvim'
	Plug 'tpope/vim-fugitive'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'simnalamburt/vim-mundo'
	Plug 'kevinhwang91/promise-async'
	Plug 'kevinhwang91/nvim-ufo'
	Plug 'mawkler/modicator.nvim'
	Plug 'smoka7/hop.nvim'
	Plug 'akinsho/bufferline.nvim'
	Plug 'mfussenegger/nvim-dap'
	Plug 'nvim-neotest/nvim-nio'
	Plug 'rcarriga/nvim-dap-ui'
	Plug 'nvim-focus/focus.nvim'
	Plug 'lukas-reineke/virt-column.nvim'
	Plug 'folke/noice.nvim'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'goolord/alpha-nvim'
	Plug 'max397574/better-escape.nvim'
	Plug 'tzachar/highlight-undo.nvim'
	Plug 'madskjeldgaard/cheeky-snippets.nvim'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'sphamba/smear-cursor.nvim'
	Plug 'folke/snacks.nvim'
	Plug 'rachartier/tiny-inline-diagnostic.nvim'
	Plug 'echasnovski/mini.indentscope'
	" Plug 'wurli/visimatch.nvim'
	Plug 'rachartier/tiny-glimmer.nvim'
	Plug 'nullromo/go-up.nvim'
	Plug 'Bekaboo/dropbar.nvim'
	Plug 'epwalsh/pomo.nvim'
call plug#end()

" Jump forward or backward
imap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
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
			"--pretty",
			"--header-insertion=never",
			-- "--background-index",
			"--suggest-missing-includes",
			"-j=4",
			"--clang-tidy",
			"--inlay-hints=true"
		},
	}

	require'lspconfig'.glsl_analyzer.setup {}

	require'lspconfig'.tsserver.setup {}

	-- Show line diagnostics automatically in hover window
	vim.o.updatetime = 250
	vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
EOF

nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <C-t> :tabnew split<CR>
nnoremap <F4> :bp \| sp \| bn \| bd<CR>

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

let g:indentLine_setColors = 0

nmap gm :LivedownToggle<CR>

lua require('config')

nmap <space><space>x <Plug>JupyterExecute
nmap <space><space>X <Plug>JupyterExecuteAll
nmap <space><space>r <Plug>JupyterRestart

autocmd TextChanged,TextChangedI <buffer> silent write

let g:indentLine_char_list = ['|', '¦', '┆', '┊']

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <F1> :Telescope buffers <CR>
nnoremap <F2> :Telescope find_files<CR>
nnoremap <F3> :Telescope live_grep<CR>
nnoremap <F5> :Telescope current_buffer_fuzzy_find<CR>
nnoremap <F10> :Telescope bookmarks list<CR>
nnoremap <F11> :Telescope git_file_history<CR>

lua << EOF
require("nvim-autopairs").setup {}
EOF

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

autocmd FileType html setlocal sw=2 ts=2
autocmd FileType vue setlocal sw=2 ts=2
autocmd FileType r setlocal sw=1 ts=1 expandtab
autocmd FileType xml setlocal sw=2 ts=2

lua << EOF
  require("todo-comments").setup {}
EOF

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
require('highlight-undo').setup({
  duration = 300,
  keymaps = {
    Keymap_name = {
      -- most fields here are the same as in vim.keymap.set
      desc = "a description",
      hlgroup = 'HighlightUndo',
      mode = 'n',
      lhs = 'lhs',
      rhs = 'optional, can be nil',
      opts = {
        -- same as opts to vim.keymap.set. if rhs is nil, there should be a
        -- callback key which points to a function
      },
    },
  },
})

require('mini.indentscope').setup({
	symbol = '┃',
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "vim" },

  sync_install = false,

  auto_install = false,

  highlight = {
    enable = true,
	disable = function(lang, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 3000
	end,
    additional_vim_regex_highlighting = false,
  },
}

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
EOF
