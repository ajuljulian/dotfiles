return {
	{
		"saghen/blink.cmp",
		enabled = true,
		dependencies = { "rafamadriz/friendly-snippets" },

		version = "*",
		opts = {
			keymap = {
				preset = "default",
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },

			completion = {
				menu = {
					border = "rounded",
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
