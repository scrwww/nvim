vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.netrw_liststyle=3
vim.g.netrw_banner=0

vim.g.clipboard = "wl-copy"

vim.o.wrap = false

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
vim.o.updatetime = 100
vim.o.timeoutlen = 300

vim.o.encoding = "UTF-8"
vim.diagnostic.config({ virtual_text = true, update_in_insert = true, severity_sort = true })

vim.o.autocomplete = true
vim.o.completeopt = "menu,menuone,noselect,noinsert,fuzzy,popup"
vim.lsp.codelens.enable()
vim.o.pumborder = "rounded"
