vim.pack.add({
        -- nav
        { src = "https://github.com/nvim-telescope/telescope.nvim" },
        { src = "https://github.com/nvim-lua/plenary.nvim" },
        { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
        { src = "https://github.com/folke/flash.nvim" },

        -- theme
        { src = "https://github.com/xiyaowong/transparent.nvim" },
        { src = "https://github.com/webhooked/kanso.nvim" },
        { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
        { src = "https://github.com/kepano/flexoki-neovim" },
        { src = "https://github.com/folke/tokyonight.nvim" },

        -- lsp and utils
        { src = "https://github.com/nvim-treesitter/nvim-treesitter",         version = "main" },

        { src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

        { src = "https://github.com/seblyng/roslyn.nvim" },
        { src = "https://github.com/MunifTanjim/nui.nvim" },
})
require("roslyn")

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, 's', function() flash.jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "x", "o" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
