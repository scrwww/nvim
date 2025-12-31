return {
        'nvim-lualine/lualine.nvim',
        config = function ()
                require('lualine').setup {
                        options = {
                                theme = 'auto',
                                component_separators = '',
                                section_separators = '',
                        },
                        lualine_a = { 'mode' },
                        lualine_b = {
                                'branch',
                                'diff',
                                {
                                        'diagnostics',
                                        source = { 'nvim' },
                                        sections = { 'error' },
                                },
                                {
                                        'diagnostics',
                                        source = { 'nvim' },
                                        sections = { 'warn' },
                                },
                                { 'filename', file_status = false, path = 1 },
                                {
                                        '%w',
                                        cond = function()
                                                return vim.wo.previewwindow
                                        end,
                                },
                                {
                                        '%r',
                                        cond = function()
                                                return vim.bo.readonly
                                        end,
                                },
                                {
                                        '%q',
                                        cond = function()
                                                return vim.bo.buftype == 'quickfix'
                                        end,
                                },
                        },
                        lualine_c = {},
                        lualine_x = {},
                        lualine_y = { search_result, 'buffer' },
                        lualine_z = { '%l:%c', '%p%%/%L' },
                }
        end
}
