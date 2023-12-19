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

-- Require and call setup function somewhere in your init.lua
require('image').setup {
  render = {
    min_padding = 0,
    show_label = true,
    use_dither = true,
    foreground_color = false,
    background_color = false
  },
  events = {
    update_on_nvim_resize = true,
  },
}

require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  },
}

--require("clangd_extensions").setup {
--    server = {
--        -- options to pass to nvim-lspconfig
--        -- i.e. the arguments to require("lspconfig").clangd.setup({})
--    },
--    extensions = {
--        -- defaults:
--        -- Automatically set inlay hints (type hints)
--        autoSetHints = true,
--        -- These apply to the default ClangdSetInlayHints command
--        inlay_hints = {
--            -- Only show inlay hints for the current line
--            only_current_line = false,
--            -- Event which triggers a refersh of the inlay hints.
--            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
--            -- not that this may cause  higher CPU usage.
--            -- This option is only respected when only_current_line and
--            -- autoSetHints both are true.
--            only_current_line_autocmd = "CursorHold",
--            -- whether to show parameter hints with the inlay hints or not
--            show_parameter_hints = false,
--            -- prefix for parameter hints
--            parameter_hints_prefix = "<- ",
--            -- prefix for all the other hints (type, chaining)
--            other_hints_prefix = "=> ",
--            -- whether to align to the length of the longest line in the file
--            max_len_align = false,
--            -- padding from the left if max_len_align is true
--            max_len_align_padding = 1,
--            -- whether to align to the extreme right or not
--            right_align = false,
--            -- padding from the right if right_align is true
--            right_align_padding = 7,
--            -- The color of the hints
--            highlight = "Comment",
--            -- The highlight group priority for extmark
--            priority = 100,
--        },
--        ast = {
--            -- These are unicode, should be available in any font
--            role_icons = {
--                 type = "🄣",
--                 declaration = "🄓",
--                 expression = "🄔",
--                 statement = ";",
--                 specifier = "🄢",
--                 ["template argument"] = "🆃",
--            },
--            kind_icons = {
--                Compound = "🄲",
--                Recovery = "🅁",
--                TranslationUnit = "🅄",
--                PackExpansion = "🄿",
--                TemplateTypeParm = "🅃",
--                TemplateTemplateParm = "🅃",
--                TemplateParamObject = "🅃",
--            },
--            --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
--            role_icons = {
--                type = "",
--                declaration = "",
--                expression = "",
--                specifier = "",
--                statement = "",
--                ["template argument"] = "",
--            },

--            kind_icons = {
--                Compound = "",
--                Recovery = "",
--                TranslationUnit = "",
--                PackExpansion = "",
--                TemplateTypeParm = "",
--                TemplateTemplateParm = "",
--                TemplateParamObject = "",
--            }, ]]

--            highlights = {
--                detail = "Comment",
--            },
--        },
--        memory_usage = {
--            border = "none",
--        },
--        symbol_info = {
--            border = "none",
--        },
--    },
--}

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
  rainbow = {
    enable =true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}


require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,

}

-- require("ibl").setup {
-- }

local iron = require("iron.core")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      }
    },
    -- How the repl window will be displayed
    -- See below for more information
    --repl_open_cmd = require('iron.view').split.vertical.botright(50),
	repl_open_cmd = require('iron.view').center("90%", 40),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- require("nvim-tree").setup {
-- 	view = {
-- 		width = 50,
-- 	},
-- 	filters = {
-- 		exclude = { 'todo.txt' }
-- 	}
-- }

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
  yadm = {
    enable = false
  },
}

require'barbar'.setup {
	animation = true,
	auto_hide = true,
	icons = {
		-- Enable highlighting visible buffers
		highlight_visible = true,
		modified = {button = '●'},
		gitsigns = {
			added = {enabled = true, icon = '+'},
			changed = {enabled = true, icon = '~'},
			deleted = {enabled = true, icon = '-'},
			modified = {enabled = true, icon = 'M'}
		},
		pinned = {button = '', filename = true},
	},
	insert_at_end = true,
}
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

require("gruvbox").setup({
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
  },
})
vim.cmd("colorscheme gruvbox")

require'lspconfig'.tsserver.setup{}
