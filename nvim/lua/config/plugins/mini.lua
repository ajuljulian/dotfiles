-- lua/config/plugins/mini.lua
return {
	{
		"echasnovski/mini.nvim",
		version = false, -- Use the latest version
		config = function()
			-- Mini.ai - Better text objects
			require("mini.ai").setup()

			-- Mini.surround - Surround functionality
			require("mini.surround").setup()

			-- Mini.pairs - Auto pairs
			require("mini.pairs").setup()

			-- Mini.comment - Better commenting (if you want to replace your current comment plugin)
			-- require("mini.comment").setup()

			-- Mini.statusline - Statusline (optional, if you want a minimal statusline)
			-- require("mini.statusline").setup()

			-- Mini.tabline - Tabline (optional)
			-- require("mini.tabline").setup()

			-- Mini.indentscope - Indent scope visualization
			require("mini.indentscope").setup()

			-- Mini.jump - Enhanced f/t motions
			require("mini.jump").setup()

			-- Mini.move - Move selections
			require("mini.move").setup()

			-- Mini.bufremove - Better buffer deletion
			require("mini.bufremove").setup()

			-- Add more mini modules as needed
		end,
	},
}