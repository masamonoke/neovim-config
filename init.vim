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

call plug#begin()
	Plug 'windwp/nvim-autopairs'
	Plug 'tpope/vim-commentary'
	Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'karb94/neoscroll.nvim'
	Plug 'itchyny/vim-gitbranch'
	Plug 'akinsho/toggleterm.nvim'
	Plug 'ellisonleao/gruvbox.nvim'
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
	Plug 'm-demare/hlargs.nvim'
	Plug 'HiPhish/rainbow-delimiters.nvim'
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
	Plug 'tzachar/highlight-undo.nvim'
	Plug 'madskjeldgaard/cheeky-snippets.nvim'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'sphamba/smear-cursor.nvim'
	Plug 'folke/snacks.nvim'
	Plug 'echasnovski/mini.indentscope'
	Plug 'nullromo/go-up.nvim'
	Plug 'NStefan002/visual-surround.nvim'
	Plug 'MeanderingProgrammer/render-markdown.nvim'
	Plug 'tzachar/local-highlight.nvim'
	Plug 'nvim-treesitter/nvim-treesitter-context'
	Plug 'slugbyte/lackluster.nvim'
call plug#end()

lua require('config')

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
nnoremap <F10> :Telescope bookmarks list<CR>
nnoremap <F11> :Telescope git_file_history<CR>

autocmd FileType html setlocal sw=2 ts=2
autocmd FileType vue setlocal sw=2 ts=2
autocmd FileType r setlocal sw=1 ts=1 expandtab
autocmd FileType xml setlocal sw=2 ts=2

set keywordprg=:call\ CocActionAsync('doHover')
nnoremap <C-]> :call CocActionAsync('jumpDefinition') <CR>
nnoremap <silent> <leader>a :call CocActionAsync('codeAction')<CR>
verbose nmap <leader>rn <Plug>(coc-rename)

augroup VimHelp
  autocmd!
  autocmd Filetype vim,help setlocal keywordprg=:help
augroup END

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set foldmethod=manual

autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

noremap d "_d

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

vnoremap < <gv
vnoremap > >gv

let g:indent_blankline_show_current_context = v:true

let g:highlighturl_guifg = '#DB7093'

hi CocInlayHint guibg=#707772

nnoremap <C-n> :NvimTreeToggle <CR>

set undofile
set undodir=~/.vim/undo

nnoremap <leader>h :HopWord<CR>

set lazyredraw

nnoremap <silent> <F10> :CocList diagnostics --current<CR>

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
	" lua require('smear_cursor').enabled = true
endif

augroup cpp_coc_settings
  autocmd!
  autocmd FileType cpp let g:coc_user_config = {
    \ "clangd": {
    \   "fallbackFlags": ["-std=c++20"]
    \ }
    \ }
augroup END

au BufNewFile,BufRead *.wgsl set filetype=wgsl
