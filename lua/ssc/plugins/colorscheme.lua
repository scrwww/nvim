function BgColoring(color)
    vim.cmd('set termguicolors')
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    "Zeioth/neon.nvim",
    lazy = false,
    priority = 1000,
    dependencies = "rktjmp/lush.nvim",
    config = function()
        BgColoring("neon-cherrykiss-storm")
    end,
}
