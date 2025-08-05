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
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local map = vim.keymap.set
					map("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Git hunk" })
					-- you can also map other gitsigns features here if you want
				end,
			})
		end,
	},
}
