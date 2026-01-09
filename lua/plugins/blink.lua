local blink = require('blink.cmp')
blink.setup({
        keymap = {
                preset = 'default',
        },

        appearance = {
                nerd_font_variant = 'mono',
        },

        completion = {
                documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 200,
                },
        },

        sources = {
                default = {
                        'lsp',
                        'path',
                        'buffer',
                        'snippets',
                },
        },
        fuzzy = { implementation = 'lua' }
})
vim.lsp.config.capabilities = blink.get_lsp_capabilities()
