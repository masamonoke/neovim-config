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
