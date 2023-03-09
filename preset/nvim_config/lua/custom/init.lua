-- local autocmd = vim.api.nvim_create_autocmd
-- require "custom.plugins"

vim.g.mapleader = ","
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.opt.shortmess:append "sIc"
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
