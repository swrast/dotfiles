vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use {
        "nvim-lualine/lualine.nvim",
	    requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
	use "nanotech/jellybeans.vim"
	use {
		"neoclide/coc.nvim",
		branch = "release"
	}
	use "preservim/nerdtree"
	use "nvim-tree/nvim-web-devicons"
	use "romgrk/barbar.nvim"
end)

