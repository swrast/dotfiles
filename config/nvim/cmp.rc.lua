local status, cmp = pcall(require, "cmp")
-- if (not status) then return end
local lspkind = require "lspkind.rc"

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behaviour = cmp.ConfirmBehaviour.Replace,
            select = true
        })
    }),
    sources = cmd.config.source({
        { name = "nvim_lsp" },
        { name = "buffer" },
    }),
    formatting = {
        format = lspkind.cmd_format({ wirth_text = false, maxWidth = 50 })
    }
})

vim.cmd [[
    set completeopt=menuone,noinsert,noselect
    highlight! default link CmpItemKind CmpItemMenuDefault
]]
