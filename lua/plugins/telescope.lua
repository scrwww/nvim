require("telescope").setup({})
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>co", function() telescope_builtin.colorscheme({enable_preview= true}) end, { desc = "Telescope colorscheme" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.bo.complete = ""
    vim.lsp.completion.enable(false, 0, vim.api.nvim_get_current_buf())
  end,
})
