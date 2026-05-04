vim.lsp.config["jdtls"] = {
        settings = {
                java = {
                        configuration = {
                                runtimes = {
                                        {
                                                name = "JavaSE-Current",
                                                path = vim.fn.expand("~/.sdkman/candidates/java/current"),
                                                default = true,
                                        },
                                        {
                                                name = "JavaSE-17",
                                                path = vim.fn.expand("~/.sdkman/candidates/java/17.0.14-jbr"),
                                        },
                                },
                        },
                },
        },
}

require("java").setup({
        -- Startup checks
        checks = {
                nvim_version = true,        -- Check Neovim version
                nvim_jdtls_conflict = true, -- Check for nvim-jdtls conflict
        },

        -- -- JDTLS configuration
        -- jdtls = {
        --         version = "1.43.0",
        -- },

        -- Extensions
        lombok = {
                enable = true,
                version = "1.18.40",
        },

        java_test = {
                enable = true,
                version = "0.40.1",
        },

        java_debug_adapter = {
                enable = true,
                version = "0.58.2",
        },

        spring_boot_tools = {
                enable = true,
                version = "1.55.1",
        },

        -- JDK installation
        jdk = {
                path = vim.fn.expand("~/.sdkman/candidates/java/current"),
                auto_install = false,
        },

        -- Logging
        log = {
                use_console = true,
                use_file = true,
                level = "info",
                log_file = vim.fn.stdpath("state") .. "/nvim-java.log",
                max_lines = 1000,
                show_location = false,
        },
})
