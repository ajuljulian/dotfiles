return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
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
