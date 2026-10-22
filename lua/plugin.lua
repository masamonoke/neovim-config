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

require("noice").setup({
	presets = {
		bottom_search = true,       -- use a classic bottom cmdline for search
		command_palette = true,     -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false,         -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false,     -- add a border to hover docs and signature help
	}
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
	status_formatter             = nil, -- Use default
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

-- vim.cmd("colorscheme koda")

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
require('ufo').setup()
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require("snacks").setup({
	quickfile = { enabled = true },
	statuscolumn = { enabled = true },
	bufdelete = { enabled = true },
	-- works bad: after insert mode on first scroll it scrolls not smooth
	scroll = {
		enabled = true,
	}
})

-- require('neoscroll').setup({})

require('mini.trailspace').setup()
require('mini.surround').setup()

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
local is_windows = os.getenv("OS") == "Windows_NT" or os.getenv("WINDIR") ~= nil

if not is_windows then
	treesitter.install({ "lua", "vim" }):wait(300000)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local ok = pcall(vim.treesitter.start, args.buf)
		if not ok then
			return
		end

		vim.bo[args.buf].syntax = ""

		if vim.bo[args.buf].filetype ~= "cpp" then
			vim.bo[args.buf].indentexpr =
			"v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

vim.api.nvim_set_hl(0, "StatusLine", { reverse = false })
vim.api.nvim_set_hl(0, "StatusLineNC", { reverse = false })
require('lualine').setup()

require('mini.indentscope').setup({
	symbol = '┃'
})

vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])   -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])   -- make the window smaller vertically
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

vim.api.nvim_set_keymap('n', '<C-c>', [[:let @+ = expand("%:p")<CR>]], { noremap = true, silent = true })

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require("trouble").setup {}
vim.keymap.set('n', '<F10>', '<cmd>Trouble diagnostics toggle<CR>')
vim.keymap.set('n', '<F11>', '<cmd>Trouble lsp_references<CR>')

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename variable' })

require('goto-preview').setup({})
vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.bo.formatprg = "rustfmt"
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "h", "hpp" },
	callback = function()
		vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})"
	end
})

-- to disable annoying sqlcomplete popup when using left and right arrows in insert mode
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sql",
	callback = function()
		vim.keymap.del('i', '<left>', { buffer = true })
		vim.keymap.del('i', '<right>', { buffer = true })
	end
})

require("nvim-autopairs").setup {}

require('hlargs').setup({
	hl_priority = 130
})

require("transparent").setup()

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })


require("codecompanion").setup({
	interactions = {
		chat = {
			adapter = "ollama",
		},
		inline = {
			adapter = "ollama",
		},
		cmd = {
			adapter = "ollama",
		},
	},

	adapters = {
		http = {
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					env = {
						url = "http://127.0.0.1:11434",
					},
					schema = {
						model = {
							default = "qwen2.5-coder:7b",
						},
					},
				})
			end,
		},
	},
})

vim.keymap.set("n", "<leader>ar", function()
	local diff = vim.fn.systemlist({
		"git",
		"diff",
		"--no-ext-diff",
		"--",
	})

	if vim.v.shell_error ~= 0 then
		vim.notify(
			"Could not read staged Git changes",
			vim.log.levels.ERROR
		)
		return
	end

	if #diff == 0 then
		vim.notify(
			"No staged Git changes to review",
			vim.log.levels.INFO
		)
		return
	end

	vim.cmd("new")

	local buf = vim.api.nvim_get_current_buf()

	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "diff"

	vim.api.nvim_buf_set_name(
		buf,
		"CodeCompanion Staged Git Diff"
	)

	vim.api.nvim_buf_set_lines(
		buf,
		0,
		-1,
		false,
		diff
	)

	vim.bo[buf].modified = false
	vim.api.nvim_win_set_cursor(0, { 1, 0 })

	-- The '%' explicitly supplies the entire diff as the source range.
	vim.cmd("%CodeCompanionChat Add")
end, {
	desc = "Add staged Git diff to CodeCompanion",
})

vim.keymap.set("n", "<A-l>", "zl", { desc = "Scroll right" })
vim.keymap.set("n", "<A-h>", "zh", { desc = "Scroll left" })
vim.keymap.set("i", "<A-l>", "<C-o>a", {
	noremap = true,
	silent = true,
	desc = "Move one character right in Insert mode"
})
vim.keymap.set("i", "<A-h>", "<C-o>h", {
	noremap = true,
	silent = true,
	desc = "Move one character left in Insert mode",
})

vim.opt.relativenumber = true

require('nibbler').setup()

vim.g.VM_filetypes = {
	blacklist = { "TelescopePrompt", "telescope", "NvimTree", "neo-tree", "lazy", "mason" },
}
