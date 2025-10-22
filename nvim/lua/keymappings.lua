--print("hello from keymappings.lua")
local opts = { noremap = true, silent = true }

-- Turn off search highlight
vim.keymap.set("n", "<Esc><Esc>", ":silent! nohls<CR>", opts)

-- List and switch buffers
vim.keymap.set("", "<leader>b", ":ls<CR>:b<Space>", { noremap = true })

-- Edit vim config
vim.keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC<CR>", opts)

-- Uppercase current word
vim.keymap.set("n", "<leader>u", "viwUe", { noremap = true })

-- Window navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true })

-- Close buffer
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)

-- Source vimrc
vim.keymap.set("n", "<leader><leader>s", ":source $MYVIMRC<CR>", opts)

-- Buffer navigation
vim.keymap.set("", "<S-L>", ":bnext<CR>", { noremap = true })
vim.keymap.set("", "<S-H>", ":bprev<CR>", { noremap = true })

-- LSP Finder (Lspsaga)
vim.keymap.set("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
vim.keymap.set("n", "gh", ":Lspsaga lsp_finder<CR>", opts) -- Optional alternative

-- Code Action
vim.keymap.set("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
vim.keymap.set("v", "<leader>ca", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
vim.keymap.set("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", opts)

-- Toggle cursor column
vim.keymap.set("n", "<Leader>c", ":set cursorcolumn!<CR>", opts)

-- Neotree plugin
vim.keymap.set("n", "<C-Z>", ":Neotree toggle<CR>", opts)
vim.keymap.set("n", "<leader>gg", "<cmd>Neotree toggle git_status<cr>", { desc = "Toggle Git Status (Neo-tree)" })

-- Floaterm toggle
vim.keymap.set("n", "<leader>ft", ":FloatermNew<CR>", opts)
vim.keymap.set("t", "<leader>ft", "<C-\\><C-n>:FloatermNew<CR>", opts)
-- Go to tab by tab number
vim.keymap.set("n", "<leader>1", "1gt", { noremap = true })
vim.keymap.set("n", "<leader>2", "2gt", { noremap = true })
vim.keymap.set("n", "<leader>3", "3gt", { noremap = true })
vim.keymap.set("n", "<leader>4", "4gt", { noremap = true })
vim.keymap.set("n", "<leader>5", "5gt", { noremap = true })
vim.keymap.set("n", "<leader>6", "6gt", { noremap = true })
vim.keymap.set("n", "<leader>7", "7gt", { noremap = true })
vim.keymap.set("n", "<leader>8", "8gt", { noremap = true })
vim.keymap.set("n", "<leader>9", "9gt", { noremap = true })
vim.keymap.set("n", "<leader>0", ":tablast<cr>", { noremap = true })

-- Find files using Telescope command-line.
vim.keymap.set("n", "<leader>ff", ':lua require("telescope.builtin").find_files()<cr>', { noremap = true })
vim.keymap.set("n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<cr>', { noremap = true })
vim.keymap.set("n", "<leader>fb", ':lua require("telescope.builtin").buffers()<cr>', { noremap = true })
vim.keymap.set("n", "<leader>fh", ':lua require("telescope.builtin").help_tags()<cr>', { noremap = true })

-- Git shortcuts
--

vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", { desc = "Open Neogit" })
vim.keymap.set("n", "<leader>gx", function()
	-- assumes you're in a file selected from Neo-tree
	require("gitsigns").diffthis()
end, { desc = "Diff current file" })
-- Show blame info for the current line
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git Blame (Fugitive)" })

-- Show full diff of current file
--vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git Diff Split (Fugitive)" })
vim.keymap.set("n", "<leader>gd", function()
	require("gitsigns").diffthis()
end, { desc = "Gitsigns Diff current file" })
-- Show log and diff for current line
vim.keymap.set("n", "<leader>gl", function()
	local line = vim.fn.line(".")
	local file = vim.fn.expand("%")
	vim.cmd("Git log -L" .. line .. ",+1:" .. file)
	vim.cmd("copen") -- optional: opens the quickfix list to show results
end, { desc = "Git Line History (Fugitive)" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

vim.keymap.set("n", "<leader>csl", ":colorscheme tokyonight-day<CR>", { desc = "Change Color Scheme to Light" })
vim.keymap.set("n", "<leader>csd", ":colorscheme tokyonight-moon<CR>", { desc = "Change Color Scheme to Dark" })

local function back_prev_window()
	local mode = vim.api.nvim_get_mode().mode
	if mode:sub(1, 1) == "t" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
	elseif mode:sub(1, 1) == "i" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	end
	vim.cmd("wincmd p")
end

vim.keymap.set({ "n", "i", "t" }, "<A-h>", back_prev_window, { desc = "Back to previous window" })
