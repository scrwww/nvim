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
        { src = "https://github.com/nvim-treesitter/nvim-treesitter",          version = "main" },
        { src = "https://github.com/nvim-mini/mini.nvim" },
        { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },


        { src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

        -- cmp
        { src = "https://github.com/hrsh7th/nvim-cmp" },
        { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
        { src = "https://github.com/hrsh7th/cmp-buffer" },

        { src = "https://github.com/seblyng/roslyn.nvim" },
        { src = "https://github.com/MunifTanjim/nui.nvim" },

        { src = "https://github.com/kawre/leetcode.nvim" },
        { src = "https://github.com/3rd/image.nvim" },

        -- java
        { src = 'https://github.com/JavaHello/spring-boot.nvim',               version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0', },
        { src = "https://github.com/MunifTanjim/nui.nvim" },
        { src = "https://github.com/mfussenegger/nvim-dap" },
        { src = "https://github.com/nvim-java/nvim-java" },
})
-- load plugin configs
require("plugins.flash")
require("plugins.telescope")
require("plugins.leetcode")
require("plugins.image")
require("plugins.lsp")
require("plugins.render-markdown")
require("plugins.java")
