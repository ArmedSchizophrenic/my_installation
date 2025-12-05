-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader><leader>', builtin.keymaps, { desc = 'Telescope help keys' })
vim.keymap.set('n', 'P', builtin.registers, { desc = 'Telescope help tags' })

-- lsp
vim.keymap.set('n', 'A', vim.lsp.buf.code_action, {})
vim.keymap.set('n', 'H', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
-- tree sitter
vim.api.nvim_set_keymap('n', 'az', 'zo', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'za', 'zc', { noremap = true, silent = true })
-- neo tree
vim.keymap.set("n", "<leader>t", ":Neotree filesystem reveal right<CR>", {})
vim.keymap.set("n", "<leader>tc", ":Neotree close<CR>", {})
-- rust
local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp('codeAction') end, { silent = true, buffer = bufnr })
vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end)

