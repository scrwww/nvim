-- local cmp = require "cmp"
-- cmp.setup({
--         snippet = {
--                 expand = function(args)
--                         vim.snippet.expand(args.body)
--                 end,
--         },
--         window = {
--                 completion = cmp.config.window.bordered(),
--                 documentation = cmp.config.window.bordered(),
--         },
--         mapping = cmp.mapping.preset.insert({
--                 ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                 ["<C-Space>"] = cmp.mapping.complete(),
--                 ["<C-e>"] = cmp.mapping.abort(),
--                 ["<CR>"] = cmp.mapping.confirm({ select = true }),
--         }),
--         sources = cmp.config.sources({
--                 { name = "nvim_lsp" },
--         }, {
--                 { name = "buffer" },
--         })
-- })
--
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
local capabilities = vim.lsp.protocol.make_client_capabilities();

require("mason").setup({
        registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
        },
})

vim.lsp.config["lua_ls"] = {
        capabilities = capabilities,
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
        settings = {
                Lua = {
                        workspace = {
                                library = {
                                        vim.fn.expand("$VIMRUNTIME/lua"),
                                        vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                                },
                                checkThirdParty = false,
                        },
                        runtime = {
                                version = "LuaJIT",
                        }
                }
        }
}

vim.lsp.config["tsserver"] = {
        capabilities = capabilities,
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}

vim.lsp.config["rust_analyzer"] = {
        capabilities = capabilities,
        settings = {
                ["rust-analyzer"] = {},
        },
}

vim.lsp.config["markdown_oxide"] = {
        capabilities = capabilities,
        cmd = { "markdown-oxide" },
        filetypes = { "markdown" },
        root_markers = { ".git", ".obsidian", ".moxide.toml" },
}

vim.lsp.config["clangd"] = {
        capabilities = capabilities,
        filetypes = { "c", "ll" }
}

vim.lsp.config["jdtls"] = {
        capabilities = capabilities,
        cmd = { "jdtls" },
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
        init_options = {
                extendedClientCapabilities = {
                        actionableRuntimeNotificationSupport = true,
                        advancedExtractRefactoringSupport = true,
                        advancedGenerateAccessorsSupport = true,
                        advancedIntroduceParameterRefactoringSupport = true,
                        advancedOrganizeImportsSupport = true,
                        advancedUpgradeGradleSupport = true,
                        classFileContentsSupport = true,
                        clientDocumentSymbolProvider = true,
                        clientHoverProvider = false,
                        executeClientCommandSupport = true,
                        extractInterfaceSupport = true,
                        generateConstructorsPromptSupport = true,
                        generateDelegateMethodsPromptSupport = true,
                        generateToStringPromptSupport = true,
                        gradleChecksumWrapperPromptSupport = true,
                        hashCodeEqualsPromptSupport = true,
                        inferSelectionSupport = { "extractConstant", "extractField", "extractInterface", "extractMethod", "extractVariableAllOccurrence", "extractVariable" },
                        moveRefactoringSupport = true,
                        onCompletionItemSelectedCommand = "editor.action.triggerParameterHints",
                        overrideMethodsPromptSupport = true
                }

        },
}

require("mason-lspconfig").setup({
        handlers = {
                function(server_name)
                        -- Skip jdtls cause handled by nvim-java
                        -- if server_name == "jdtls" then
                        --         return
                        -- end
                        -- Use vim.lsp.enable to start servers with configurations from vim.lsp.config
                        vim.lsp.enable(server_name)
                end
        },
})

vim.lsp.config["roslyn"] = {
        capabilities = capabilities,
        on_attach = function()
                print("Roslyn attached!")
        end,
        settings = {
                ["csharp|background_analysis"] = {
                        dotnet_analyzer_diagnostics_scope = "fullSolution",
                        dotnet_compiler_diagnostics_scope = "fullSolution",
                },
                ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                },
                ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true,
                },
                ["csharp|completion"] = {
                        dotnet_show_completion_items_from_unimported_namespaces = true,
                        dotnet_provide_regex_completions = true
                },
                ["csharp|symbol_search"] = {
                        dotnet_search_reference_assemblies = true
                },
        },
}

-- Global LSP settings for each of the servers
-- Inlay hints are enabled globally, but its done after all other configs, for performance!
-- But I found a problem, thats probably a conflict with nvim-java
-- FIXED BY JUST DOING JDTLS MANUALLY LETS HGOOOOOOOOOOOO
vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
        callback = function(ev)
                local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
                if client:supports_method("textDocument/completion") then
                        vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
                        vim.keymap.set("i", "<C-Space>", function()
                                vim.lsp.completion.get()
                        end)
                end

                -- buf keymaps
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
})
