return {
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"sbdchd/neoformat",
		config = function()
			require("config.neoformat")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8", -- or the latest stable release
		dependencies = {
			"nvim-lua/plenary.nvim", -- required dependency
		},
		config = function()
			require("telescope").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup()
		end,
	},
}
