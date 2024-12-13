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
	Plug 'voldikss/vim-floaterm'
	Plug 'lukas-reineke/indent-blankline.nvim'
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
	Plug 'folke/twilight.nvim'
	Plug 'rcarriga/nvim-notify'
	Plug 'rachartier/tiny-inline-diagnostic.nvim'
	Plug 'echasnovski/mini.indentscope'
call plug#end()

let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_keymap_next = '<F8>'
let g:floaterm_keymap_kill = '<F9>'
let g:floaterm_wintype = 'float'
let g:floaterm_height = 50
let g:floaterm_width = 170

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

highlight CocErrorFloat ctermfg=204 guifg=#ffffff

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


set keywordprg=:call\ CocActionAsync('doHover')
nnoremap <C-]> :call CocActionAsync('jumpDefinition') <CR>

augroup VimHelp
  autocmd!
  autocmd Filetype vim,help setlocal keywordprg=:help
augroup END

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

let g:pydoc_open_cmd = 'tabnew'

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

nnoremap <silent> <leader>a :call CocActionAsync('codeAction')<CR>
verbose nmap <leader>rn <Plug>(coc-rename)

set undofile
set undodir=~/.vim/undo

nnoremap <leader>h :HopWord<CR>

lua require('smear_cursor').enabled = true

set lazyredraw

au WinEnter * setl winhl=WinSeparator:WinSeparatorA
au WinLeave * setl winhl=WinSeparator:WinSeparator

