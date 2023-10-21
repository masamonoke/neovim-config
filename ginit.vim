if $TERM_PROGRAM != "Apple_Terminal"
    set termguicolors
endif
syntax on
set ts=4 sw=4
set nostartofline
set autoindent
set smartindent
set number
set smarttab
set expandtab
set mouse=a
set noswapfile
set nowrap
set hlsearch
set clipboard+=unnamedplus

function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=40 guibg=#00FF00 guifg=#000000
endfunction

call plug#begin()
"Plug 'junegunn/rainbow_parentheses.vim'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'bagrat/vim-buffet'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'lfv89/vim-interestingwords'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'karb94/neoscroll.nvim'
Plug 'itchyny/vim-gitbranch'
Plug 'voldikss/vim-floaterm'
Plug 'Yggdroot/indentLine'
Plug 'ARM9/arm-syntax-vim'

"Plug 'theniceboy/nvim-deus'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'xiyaowong/nvim-transparent'

Plug 'justinmk/vim-sneak'

" JS/JSX/TS
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
" TS from here https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-lua/plenary.nvim'

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

Plug 'bmatcuk/stylelint-lsp'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'ray-x/lsp_signature.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'samodostal/image.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'p00f/clangd_extensions.nvim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'shime/vim-livedown'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'universal-ctags/ctags'
Plug 'untitled-ai/jupyter_ascending.vim'
call plug#end()

"color deus
color gruvbox-material
"color gruvbox
"color gruvbox-baby

" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" autocmd VimEnter * RainbowParentheses
" let g:rainbow#max_level = 20
" let g:rainbow#blacklist = [188, 231, 215, 220, 230, 180, 221, 226, "#ebdbb2", "#ffa61a"]

let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_keymap_next = '<F8>'
let g:floaterm_wintype = 'split'
let g:floaterm_height = 20
hi Floaterm guibg=black

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
"noremap <Leader><Tab> :Bw<CR>
"noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t> :tabnew split<CR>
nnoremap <M-Left> :tabprevious<CR>
nnoremap <M-Right> :tabnext<CR>
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>""
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <F6> :NERDTreeToggle<CR>
nnoremap <F4> :bp \| sp \| bn \| bd<CR>
let g:NERDTreeWinSize=50
set guicursor=i:block

lua << EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'
local async = require "plenary.async"

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
    autocomplete = false
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      floating_window = true,
      floating_window_above_cur_line = true,
      floating_window_off_x = 20,
      doc_lines = 10,
      hint_prefix = '👻 '
    }, bufnr)  -- Note: add in lsp client on-attach
end

-- TS setup
local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

nvim_lsp.tsserver.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
        buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
        buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
        on_attach(client, bufnr)
    end,
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
})

-- Stylelint format after save
require'lspconfig'.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      --autoFixOnSave = true,
      --autoFixOnFormat = true,
    }
  }
}


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
highlight CocErrorFloat ctermfg=204 guifg=#ffffff

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

let g:indentLine_setColors = 0

nmap gm :LivedownToggle<CR>

lua require('config')

nmap <space><space>x <Plug>JupyterExecute
nmap <space><space>X <Plug>JupyterExecuteAll
nmap <space><space>r <Plug>JupyterRestart

autocmd TextChanged,TextChangedI <buffer> silent write

Guifont! JetBrainsMono Nerd Font Mono:h13
