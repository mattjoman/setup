------------------------------------------------------------
-- basics

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.foldlevelstart = 99      -- initial folding

vim.wo.nu = true
vim.wo.relativenumber = true

vim.cmd [[colorscheme gruvbox]]
--vim.cmd [[colorscheme nord]]
--vim.cmd [[colorscheme zenburn]]

------------------------------------------------------------
-- keymaps

local keymap = vim.api.nvim_set_keymap

keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})

local opts = { noremap = true }

keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)
keymap('n', '<c-f>', ':NERDTreeToggle<CR>', opts)
keymap('n', 'tt', ':!', opts)
