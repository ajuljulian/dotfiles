return {
	{
		"zbirenbaum/copilot.lua",
		build = ":Copilot auth",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
				},
				panel = { enabled = true },
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot.lua", -- REQUIRED
			"nvim-lua/plenary.nvim", -- REQUIRED
		},
		config = function()
			require("CopilotChat").setup({
				-- optional config here
			})
		end,
	},
}
