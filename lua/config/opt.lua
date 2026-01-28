vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
vim.api.nvim_set_hl(0, "EndOfBuffer", {bg = "none"})

vim.o.autoindent = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 8
vim.o.tabstop = 8
vim.o.softtabstop = 8

vim.o.number = true
vim.o.relativenumber = true

vim.o.autowrite = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.updatetime = 200
vim.o.timeoutlen = 300

vim.o.encoding = "UTF-8"
vim.diagnostic.config({virtual_text=true})

