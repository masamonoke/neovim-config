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

local actions = require('telescope.actions')
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
					["<S-Tab>"] = false,
				},
			},
		},
	},
	pickers = {
		buffers = {
			initial_mode = "normal",
			mappings = {
				n = {
					["dd"] = actions.delete_buffer,
				},
			},
		},
	},
}
require("telescope").load_extension "file_browser"
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

require("noice").setup({
	presets = {
		bottom_search = true,       -- use a classic bottom cmdline for search
		command_palette = true,     -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false,         -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false,     -- add a border to hover docs and signature help
	},
	routes = { { view = "notify", filter = { event = "msg_showmode" }, }, },
})

require("toggleterm").setup({
	open_mapping = [[<F12>]],
	direction = "float",
})

require("virt-column").setup({
})

require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

require('gitsigns').setup {
	signs                        = {
		add          = { text = '│' },
		change       = { text = '│' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir                 = {
		follow_files = true
	},
	attach_to_untracked          = true,
	current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts      = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
	sign_priority                = 6,
	update_debounce              = 100,
	status_formatter             = nil,  -- Use default
	max_file_length              = 40000, -- Disable if file is longer than this (in lines)
	preview_config               = {
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

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require('ufo').setup()

require("snacks").setup({
	quickfile = { enabled = true },
	statuscolumn = { enabled = true },
	bufdelete = { enabled = true },
	-- I was forced to patch snacks with code inside scroll.lua in M.enable to catch state change
	-- after buffer save to mitigate problem with jumps:
	--   vim.api.nvim_create_autocmd("BufWritePost", {
  --   group = group,
  --   callback = vim.schedule_wrap(function(ev)
  --     if not M.enabled then
  --       return
  --     end
  --
  --     for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
  --       State.get(win)
  --     end
  --   end),
  -- })
  --
	scroll = {
		enabled = true,
		duration = 200,
		easing = "linear",
	},
	scratch = {
		enabled = true
	}
})

require('mini.trailspace').setup()
require('mini.surround').setup()
require('mini.indentscope').setup({
	symbol = '┃'
})
require('mini.notify').setup()
require('mini.starter').setup()

require("todo-comments").setup {}

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
			reveal = { 'close' }
		},
		diagnostics = "nvim_lsp",
		always_show_bufferline = false
	}
})

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
	disable_filetypes = { "pdf" },
}

require('colorful-winsep').setup()

-- INFO: this treesitter setup not compatible with nvim version < 0.12
local treesitter = require("nvim-treesitter")
treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })
require('lualine').setup()

require("trouble").setup {}

require('goto-preview').setup({})

require("nvim-autopairs").setup {}

require('hlargs').setup({
	hl_priority = 130
})

require("transparent").setup()

vim.opt.relativenumber = true

require('nibbler').setup()

vim.g.VM_filetypes = {
	blacklist = { "TelescopePrompt", "telescope", "NvimTree", "neo-tree", "lazy", "mason" },
}

require('guess-indent').setup {}

require('Comment').setup()

require("scroll").setup({
	minimap = false,
	marks = {
		git = true,
		diagnostics = { severity = { min = vim.diagnostic.severity.WARN } },
	},
	visibility = "always",
	horizontal = {
		enabled = false,
	}
})

require('vellum').setup()

require("mermaid").setup()

require("auto-session").setup()
