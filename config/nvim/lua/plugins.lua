vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use {
        "nvim-lualine/lualine.nvim",
	    requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
	use "nanotech/jellybeans.vim"
	use "preservim/nerdtree"
	use "nvim-tree/nvim-web-devicons"
	use "romgrk/barbar.nvim"
    use "onsails/lspkind-nvim"
    
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/nvim-cmp"

    use "neovim/nvim-lspconfig"
end)

