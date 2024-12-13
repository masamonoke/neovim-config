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

require('mini.indentscope').setup({
	symbol = '┃',
})

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

require 'nt-cpp-tools'.setup({
    preview = {
        quit = 'q', -- optional keymapping for quit preview
        accept = '<tab>' -- optional keymapping for accept preview
    },
    header_extension = 'h', -- optional
    source_extension = 'cxx', -- optional
    custom_define_class_function_commands = { -- optional
        TSCppImplWrite = {
            output_handle = require'nt-cpp-tools.output_handlers'.get_add_to_cpp()
        }
        --[[
        <your impl function custom command name> = {
            output_handle = function (str, context) 
                -- string contains the class implementation
                -- do whatever you want to do with it
            end
        }
        ]]
    }
})

-- require 'neocodeium'.setup({
--   "monkoose/neocodeium",
--   event = "VeryLazy",
--   opts = {
--     server = {
--       api_url = 'https://codeium.company.net/_route/api_server',
--       portal_url = 'https://codeium.company.net',
--     },
--   }
-- })
-- vim.keymap.set("i", "<A-f>", function()
--     require("neocodeium").accept()
-- end)
-- vim.keymap.set("i", "<A-c>", function()
--     require("neocodeium").clear()
-- end)
-- vim.keymap.set("i", "<A-w>", function()
--     require("neocodeium").accept_word()
-- end)
-- vim.keymap.set("i", "<A-a>", function()
--     require("neocodeium").accept_line()
-- end)
-- vim.keymap.set("i", "<A-e>", function()
--     require("neocodeium").cycle_or_complete()
-- end)
-- vim.keymap.set("i", "<A-r>", function()
--     require("neocodeium").cycle_or_complete(-1)
-- end)

require('bookmarks').setup {
  sign_priority = 1000,  --set bookmark sign priority to cover other sign
  save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
  keywords =  {
    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
    ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
    ["@n"] = "👺", -- mark annotation startswith @n ,signs this icon as `Note`
  },
  on_attach = function(bufnr)
    local bm = require "bookmarks"
    local map = vim.keymap.set
    map("n","mm",bm.bookmark_toggle) -- add or remove bookmark at current line
    map("n","mi",bm.bookmark_ann) -- add or edit mark annotation at current line
    map("n","mc",bm.bookmark_clean) -- clean all marks in local buffer
    map("n","mn",bm.bookmark_next) -- jump to next mark in local buffer
    map("n","mp",bm.bookmark_prev) -- jump to previous mark in local buffer
    map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
    map("n","mx",bm.bookmark_clear_all) -- removes all bookmarks
  end
}

require('telescope').load_extension('bookmarks')

require("telescope").load_extension("git_file_history")

-- vim.notify = require("notify")

require('lualine').setup()

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require('ufo').setup()
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('modicator').setup()

require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

local bufferline = require('bufferline')
bufferline.setup({
	options = {
		separator_style = "slant",
		buffer_close_icon = '󰅖',
		modified_icon = '● ',
		close_icon = ' ',
		left_trunc_marker = ' ',
		right_trunc_marker = ' ',
		truncate_names = false,
		color_icons = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = {'close'}
		},
		diagnostics = "coc"
	}
})

require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = false,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        if line_count > 1000 then
            vim.g.neoscroll_performance_mode = true
        else
            vim.g.neoscroll_performance_mode = false
        end
    end,
})

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

vim.keymap.set('n', 'C', function() require('dap').continue() end)
vim.keymap.set('n', 'O', function() require('dap').step_over() end)
vim.keymap.set('n', 'I', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

local ui = require "dapui"

 require("dapui").setup()

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
	require("dapui").eval(nil, { enter = true })
end)
dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" })

require("focus").setup()

require("virt-column").setup({
	virtcolumn = "130"
})

 require("noice").setup({
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	}
})

require("better_escape").setup()

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

require("cheeky").setup({
	langs = {
		all = true,
		lua = true,
		cpp = true,
		asm = true,
		cmake = true,
		markdown = true,
		supercollider = true
	},
})

-- require("focushere").setup()
-- vim.keymap.set("v","<Leader>f" , ":FocusHere<CR>" , {noremap=true, silent=true})
-- vim.keymap.set("n","<Leader>f" , ":FocusClear<CR>" , {noremap=true, silent=true})

require("snacks").setup({
	bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
	bufdelete = { enabled = true }
})

require("twilight").setup({
	dimming = {
		alpha = 0.25,
		color = { "Normal", "#ffffff" },
		term_bg = "#000000",
		inactive = false,
	},
	context = 30,
	treesitter = true,
	expand = {
		"function",
		"method",
		"table",
		"if_statement",
	},
	exclude = {},
})

vim.notify = require("notify")

require("auto-save").setup {
	execution_message = {
		message = function()
			return ("")
		end,
	}
}

require('tiny-inline-diagnostic').setup()

vim.diagnostic.config({ virtual_text = false })
