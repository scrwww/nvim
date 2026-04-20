require("mason").setup({
        registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
        },
})
require('mason-lspconfig').setup({
        handlers = {
                function(server_name)
                        require("lspconfig")[server_name].setup {}
                end
        },
})

vim.lsp.config['lua_ls'] = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
        settings = {
                Lua = {
                        workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                        },
                        runtime = {
                                version = 'LuaJIT',
                        }
                }
        }
}

vim.lsp.config['tsserver'] = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
                'typescript',
                'typescriptreact',
                'javascript',
                'javascriptreact',
        },
        root_markers = {
                'package.json',
                'tsconfig.json',
                'jsconfig.json',
                '.git',
        },
}

vim.lsp.config('jdtls', {
        settings = {
                java = {
                        configuration = {
                                runtimes = {
                                        {
                                                path = "~/.sdkman/candidates/java/current/bin/java",
                                                default = true,
                                        }
                                }
                        }
                }
        }
})

vim.lsp.config('rust_analyzer', {
        settings = {
                ['rust-analyzer'] = {},
        },
})

vim.lsp.config("roslyn", {
    on_attach = function()
        print("This will run when the server attaches!")
    end,
    settings = {
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
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('tsserver')
vim.lsp.enable('jdtls')
vim.lsp.enable('clangd')

vim.lsp.inlay_hint.enable(true, { not vim.lsp.inlay_hint.is_enabled() })

vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(ev)
                local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
                if client:supports_method('textDocument/implementation') then
                        -- Create a keymap for vim.lsp.buf.implementation ...
                end
                -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
                if client:supports_method('textDocument/completion') then
                        -- Optional: trigger autocompletion on EVERY keypress. May be slow!
                        -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                        -- client.server_capabilities.completionProvider.triggerCharacters = chars
                        vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
                end
                -- Auto-format ("lint") on save.
                -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
                if not client:supports_method('textDocument/willSaveWaitUntil')
                        and client:supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                                group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
                                buffer = ev.buf,
                                callback = function()
                                        vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                                end,
                        })
                end
        end,
})
