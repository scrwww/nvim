vim.pack.add({
        -- nav
        { src = "https://github.com/nvim-telescope/telescope.nvim" },
        { src = "https://github.com/nvim-lua/plenary.nvim" },
        { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

        -- theme
        { src = "https://github.com/xiyaowong/transparent.nvim" },
        { src = "https://github.com/webhooked/kanso.nvim" },
        { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
        { src = "https://github.com/kepano/flexoki-neovim" },
        { src = "https://github.com/folke/tokyonight.nvim" },
        { src = "https://github.com/nordtheme/vim" },

        -- lsp and utils
        { src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },
        { src = "https://github.com/nvim-mini/mini.nvim" },
        { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
        { src = "https://github.com/nvim-tree/nvim-web-devicons" },

        { src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

        -- cmp
        { src = "https://github.com/hrsh7th/nvim-cmp" },
        { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
        { src = "https://github.com/hrsh7th/cmp-buffer" },

        -- csharp
        { src = "https://github.com/seblyng/roslyn.nvim" },
        { src = "https://github.com/MunifTanjim/nui.nvim" },

        -- leetcode
        { src = "https://github.com/kawre/leetcode.nvim" },
        { src = "https://github.com/3rd/image.nvim" },

        -- java
        { src = "https://github.com/mfussenegger/nvim-jdtls" },

})
-- load plugin configs
require("plugins.telescope")
require("plugins.devicons")
require("plugins.leetcode")
require("plugins.image")
require("plugins.lsp")
require("plugins.render-markdown")
