require("plugins")
require("lsp")

vim.cmd [[colorscheme jellybeans]]
-- vim.cmd [[autocmd VimEnter * NERDTreeVCS]]

require("lualine").setup()

local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.nu = true
set.autoindent = true
set.hlsearch = true
set.expandtab = true
set.shell = "zsh"
set.inccommand = "split"
set.ignorecase = true
set.smarttab = true
set.breakindent = true
set.ai = true
set.si = true
set.wrap = true
set.backspace = "start,eol,indent"
set.path:append { "**" }
set.wildignore:append { "*/node_modules/*" }
set.formatoptions:append { "r" }

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste"
})

vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

