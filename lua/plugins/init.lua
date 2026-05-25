vim.pack.add({
        -- nav
        { src = "https://github.com/nvim-telescope/telescope.nvim" },
        { src = "https://github.com/nvim-lua/plenary.nvim" },
        { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

        -- theme
        { src = "https://github.com/xiyaowong/transparent.nvim" },
        { src = "https://github.com/nordtheme/vim" },

        -- lsp and utils
        { src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },
        { src = "https://github.com/nvim-tree/nvim-web-devicons" },

        { src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})
-- load plugin configs
require("plugins.telescope")
require("plugins.devicons")
require("plugins.lsp")
