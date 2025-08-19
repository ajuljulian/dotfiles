return {
	{
		"saghen/blink.cmp",
		enabled = false,
		dependencies = { "rafamadriz/friendly-snippets" },

		version = "*",
		opts = {
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
