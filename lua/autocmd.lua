local function set_filetype(patterns, filetype)
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = patterns,
    callback = function(args)
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          vim.bo[args.buf].filetype = filetype
        end
      end)
    end,
  })
end

-- automatic filetype set doesn't work for these types
set_filetype({ "*.pro", "*.pri" }, "qmake")

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.commentstring = "/* %s */"
  end,
})
