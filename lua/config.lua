require("telescope").setup {
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

require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = false,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "lua", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- rainbow = {
  --   enable =true,
  --   -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  --   max_file_lines = 1000, -- Do not enable for files with more than n lines, int
  --   -- colors = {}, -- table of hex strings
  --   -- termcolors = {} -- table of colour name strings
  -- }
}

require("ibl").setup {
	scope = {
		highlight = {
			"Label"
		}
	}
}

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

-- vim.cmd("colorscheme gruvbox-material")
-- vim.cmd("let g:gruvbox_material_enable_bold = 1")

require('auto-session').setup()
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- require('fold-preview').setup({})

require('hlargs').setup()

require("scrollbar").setup()

vim.cmd([[autocmd BufRead,BufEnter *.lua set filetype=lua]])

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
