local cmp = require "cmp"
cmp.setup({
        snippet = {
                expand = function(args)
                        vim.snippet.expand(args.body)
                end,
        },
        window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
                { name = "nvim_lsp" },
        }, {
                { name = "buffer" },
        })
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
}

require("mason-lspconfig").setup({
        handlers = {
                function(server_name)
                        -- Skip jdtls cause handled by nvim-java
                        if server_name == "jdtls" then
                                return
                        end
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

require("roslyn").setup({})

-- Global LSP settings for each of the servers
-- Inlay hints are enabled globally, but its done after all other configs, for performance!
vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
        callback = function(ev)
                local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

                -- buf keymaps
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

                -- refresh codelens on enter/leave insert to pull diagnostics/lenses
                if client:supports_method("textDocument/codeLens") then
                        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
                                group = vim.api.nvim_create_augroup("my.lsp.codelens", { clear = false }),
                                buffer = ev.buf,
                                callback = function()
                                        vim.lsp.codelens.refresh()
                                end,
                        })
                end

                if not client:supports_method("textDocument/willSaveWaitUntil")
                    and client:supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                                group = vim.api.nvim_create_augroup("my.lsp.format." .. ev.buf, { clear = true }),
                                buffer = ev.buf,
                                callback = function()
                                        vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                                end,
                        })
                end
        end,
})
