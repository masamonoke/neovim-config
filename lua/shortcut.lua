-- TODO: get map and simplify

local map = vim.keymap

map.set("n", "<F6>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = false })

map.set('n', 'zR', require('ufo').openAllFolds)
map.set('n', 'zM', require('ufo').closeAllFolds)

map.set("n", "<leader>.", function()
  Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

map.set("n", "=", [[<cmd>vertical resize +5<cr>]])   -- make the window biger vertically
map.set("n", "-", [[<cmd>vertical resize -5<cr>]])   -- make the window smaller vertically
map.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
map.set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

map.set('n', '<C-c>', [[:let @+ = expand("%:p")<CR>]], { noremap = true, silent = true })

map.set('n', '<F10>', '<cmd>Trouble diagnostics toggle<CR>')
map.set('n', '<F11>', '<cmd>Trouble lsp_references<CR>')

map.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

map.set('n', '<leader>t', vim.lsp.buf.type_definition, { desc = "Go to Type Definition" })
map.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename variable' })

map.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })

map.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true })
map.set("n", "<A-Up>", ":m .-2<CR>==", { silent = true })
map.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })
map.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })

map.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
map.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
map.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
map.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })

map.set("n", "<A-l>", "zl", { desc = "Scroll right" })
map.set("n", "<A-h>", "zh", { desc = "Scroll left" })
map.set("i", "<A-l>", "<C-o>a", {
	noremap = true,
	silent = true,
	desc = "Move one character right in Insert mode"
})
map.set("i", "<A-h>", "<C-o>h", {
	noremap = true,
	silent = true,
	desc = "Move one character left in Insert mode",
})

map.set('', '<Tab>', ':bn<CR>', { silent = true })
map.set('', '<S-Tab>', ':bp<CR>', { silent = true })

map.set('n', '<F4>', ':bp | sp | bn | bd<CR>', { silent = true })

map.set('n', '<C-p>', '<C-i>')

map.set('n', '<F1>', '<cmd>Telescope buffers<CR>')
map.set('n', '<F2>', '<cmd>Telescope find_files<CR>')
map.set('n', '<F3>', '<cmd>Telescope live_grep<CR>')
map.set('n', '<F5>', '<cmd>Telescope current_buffer_fuzzy_find<CR>')

map.set('n', '<C-g>', '<cmd>NvimTreeToggle<CR>')

map.set('n', 'f', '<cmd>HopWord<CR>')
