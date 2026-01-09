vim.lsp.enable('lua_ls')
vim.lsp.enable('tsserver')
vim.lsp.enable('jdtls')

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

local lsp_format_augroup = vim.api.nvim_create_augroup('my.lsp.format', { clear = false })
local lsp_augroup = vim.api.nvim_create_augroup('my.lsp', { clear = true })

local function on_attach(client, bufnr)
  -- Disable tsserver formatting
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end

  -- Inlay hints
  if client:supports_method('textDocument/inlayHint') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Format on save
  if not client:supports_method('textDocument/willSaveWaitUntil')
    and client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = lsp_format_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          id = client.id,
          timeout_ms = 1000,
        })
      end,
    })
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_augroup,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    on_attach(client, args.buf)
  end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--         group = vim.api.nvim_create_augroup('my.lsp', {}),
--         callback = function(args)
--                 local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--                 if client:supports_method('textDocument/completion') then
--                         vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--                 end
--
--                 -- Auto-format ("lint") on save.
--                 -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--                 if not client:supports_method('textDocument/willSaveWaitUntil')
--                     and client:supports_method('textDocument/formatting') then
--                         vim.api.nvim_create_autocmd('BufWritePre', {
--                                 group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
--                                 buffer = args.buf,
--                                 callback = function()
--                                         vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
--                                 end,
--                         })
--                 end
--         end,
-- })
-- vim.cmd("set completeopt+=noselect")
