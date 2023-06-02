require("plugins")

vim.cmd [[colorscheme jellybeans]]
-- vim.cmd [[autocmd VimEnter * NERDTreeVCS]]

require("lualine").setup()

local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.nu = true
