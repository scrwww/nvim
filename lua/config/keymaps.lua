vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<S-h>', ':bprevious<CR>', {desc = "Previous buffer", noremap = true, silent = true})
vim.keymap.set('n', '<S-l>', ':bnext<CR>', {desc = "Next buffer", noremap = true, silent = true})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Move selected line(s) down", noremap = true, silent = true})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Move selected line(s) up", noremap = true, silent = true})

vim.keymap.set("n", "<C-h>", "<C-w>h", {desc = "Change window - left", noremap = true, silent = true})
vim.keymap.set("n", "<C-j>", "<C-w>j", {desc = "Change window - down", noremap = true, silent = true})
vim.keymap.set("n", "<C-k>", "<C-w>k", {desc = "Change window - up", noremap = true, silent = true})
vim.keymap.set("n", "<C-l>", "<C-w>l", {desc = "Change window - right", noremap = true, silent = true})
