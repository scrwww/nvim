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
