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

call plug#begin()
"Plug 'preservim/nerdtree'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'lfv89/vim-interestingwords'
"Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'karb94/neoscroll.nvim'
Plug 'itchyny/vim-gitbranch'
Plug 'voldikss/vim-floaterm'
Plug 'lukas-reineke/indent-blankline.nvim', {'tag': 'v2.20.8'}
Plug 'ARM9/arm-syntax-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'neovim/nvim-lspconfig'
" Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'xiyaowong/nvim-transparent'
Plug 'justinmk/vim-sneak'
Plug 'pangloss/vim-javascript'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'samodostal/image.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'p00f/clangd_extensions.nvim'
" Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'shime/vim-livedown'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'tag': 'v0.9.4'}
Plug 'p00f/nvim-ts-rainbow'
" Plug 'rainbow-delimiters.nvim'
Plug 'universal-ctags/ctags'
Plug 'untitled-ai/jupyter_ascending.vim'
Plug 'jalvesaq/Nvim-R'
Plug 'ryanoasis/vim-devicons'
Plug 'folke/todo-comments.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Vigemus/iron.nvim'
Plug 'fs111/pydoc.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'udalov/kotlin-vim'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'PhilRunninger/nerdtree-buffer-ops'
" Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope-file-browser.nvim'
"Plug 'bfrg/vim-cpp-modern'
" Plug 'jlcrochet/vim-cs'
Plug 'jlcrochet/vim-razor'
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'romgrk/barbar.nvim'
Plug 'sindrets/diffview.nvim'
" Plug 'akinsho/toggleterm.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
call plug#end()

"color deus
"color gruvbox-material
" color gruvbox
"color gruvbox-baby

" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" autocmd VimEnter * RainbowParentheses
" let g:rainbow#max_level = 20
" let g:rainbow#blacklist = [188, 231, 215, 220, 230, 180, 221, 226, "#ebdbb2", "#ffa61a"]

let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_keymap_next = '<F8>'
let g:floaterm_keymap_kill = '<F9>'
let g:floaterm_wintype = 'float'
let g:floaterm_height = 45
let g:floaterm_width = 160
" hi Floaterm guibg=black

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

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nmap <F6> :NERDTreeToggle<CR>
" let g:NERDTreeWinSize=50
" let NERDTreeShowHidden=1

nnoremap <F4> :bp \| sp \| bn \| bd<CR>

set guicursor=i:block

" let g:buffet_powerline_separators = 1
" let g:buffet_tab_icon = "\uf00a"
" let g:buffet_left_trunc_icon = "\uf0a8"
" let g:buffet_right_trunc_icon = "\uf0a9"
" let g:buffet_show_index = 1

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

"lua << EOF
"require("telescope").setup {
"  extensions = {
"    file_browser = {
"      theme = "ivy",
"      -- disables netrw and use telescope-file-browser in its place
"      hijack_netrw = true,
"    },
"  },
"}
"EOF

"lua << EOF
"require("telescope").load_extension "file_browser"
"vim.api.nvim_set_keymap(
"  "n",
"  "<F5>",
"  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
"  { noremap = false}
")
"EOF

" lua << EOF
" require('telescope').load_extension('fzf')
" EOF

"coc
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <F1> :Telescope buffers <CR>
nnoremap <F2> :Telescope find_files<CR>
nnoremap <F3> :Telescope live_grep<CR>


lua << EOF
require("nvim-autopairs").setup {}
EOF

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

autocmd FileType html setlocal sw=2 ts=2
autocmd FileType vue setlocal sw=2 ts=2
autocmd FileType r setlocal sw=1 ts=1 expandtab
autocmd FileType xml setlocal sw=2 ts=2

let g:airline_powerline_fonts = 1
let g:airline_theme = "deus"
"let g:airline#extensions#tabline#enabled = 1

lua << EOF
  require("todo-comments").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" Check if NERDTree is open or active
" function! IsNERDTreeOpen()
"   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction

set keywordprg=:call\ CocActionAsync('doHover')
augroup VimHelp
  autocmd!
  autocmd Filetype vim,help setlocal keywordprg=:help
augroup END

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

hi @define.c guifg=coral3
hi @constant.c guifg=IndianRed1

let g:pydoc_open_cmd = 'tabnew'

set foldmethod=manual

autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

noremap d "_d

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

nnoremap <C-b> :lua require'dap'.toggle_breakpoint() <CR>
nnoremap <C-m> :lua require'dap'.continue() <CR>
nnoremap <C-n> :lua require'dap'.step_over() <CR>
nnoremap <C-s> :lua require'dap'.step_into() <CR>
nnoremap <F5> :lua require'dap'.repl.open() <CR>
