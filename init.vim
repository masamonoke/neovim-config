if $TERM_PROGRAM != "Apple_Terminal"
    set termguicolors
endif
syntax on
set nostartofline
set number
set mouse=a
set noswapfile
set nowrap
set hlsearch
set clipboard+=unnamedplus
set noshowmode
set cursorline
set guicursor=n-v-c:block,i:ver25
set foldmethod=syntax
set conceallevel=1

call plug#begin()
Plug 'windwp/nvim-autopairs'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'itchyny/vim-gitbranch'
Plug 'akinsho/toggleterm.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main' }
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
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-zh/colorful-winsep.nvim'
Plug 'echasnovski/mini.indentscope'
Plug 'rmagatti/goto-preview'
Plug 'm-demare/hlargs.nvim'
Plug 'xiyaowong/transparent.nvim'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'oskarnurm/koda.nvim'
Plug 'mrcjkb/haskell-tools.nvim'
Plug 'neovim/nvim-lspconfig'
" TODO: upgrade to v2
Plug 'Saghen/blink.cmp', { 'branch': 'v1' }
Plug 'folke/trouble.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'nvim-mini/mini.nvim'
Plug 'olimorris/codecompanion.nvim'
Plug 'dchinmay2/clangd_extensions.nvim'
Plug 'Skosulor/nibbler'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'sheerun/vim-polyglot'
Plug 'numtostr/comment.nvim'
Plug 'mihovilrak/scroll.nvim'
Plug 'blackhat-7/vellum.nvim'
Plug 'kevalin/mermaid.nvim'
Plug 'vgraman0/glinter'
Plug 'brianhuster/live-preview.nvim'
Plug 'rmagatti/auto-session'
Plug 'chrisgrieser/nvim-recorder'
Plug 'kylechui/nvim-surround'
Plug 'CoreyKaylor/diffbandit.nvim'
Plug 'FabijanZulj/blame.nvim'
Plug 'olimorris/codecompanion.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'folke/which-key.nvim'
call plug#end()

lua << EOF
require("plugin")
require("lsp")
require("autocmd")
require("shortcut")
require("llm")
EOF

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set undofile
set undodir=~/.vim/undo

au BufNewFile,BufRead *.wgsl set filetype=wgsl

xnoremap d "_d

vnoremap < <gv
vnoremap > >gv
nnoremap ciw "_ciw

highlight LspInlayHint guibg=#707772

autocmd FileType markdown setlocal wrap
autocmd FileType markdown setlocal linebreak

set tabstop=2
set shiftwidth=2
set softtabstop=0
set noexpandtab
