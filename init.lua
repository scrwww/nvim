require("config.opt")
require("config.keymaps")

require("plugins")

-- enable/disable plugins here
require("plugins.lsp")
require("plugins.flash")
require("plugins.telescope")
require("plugins.mason")
require("plugins.blink")
require("plugins.java")

vim.cmd.colorscheme("retrobox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none"})
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none"})
