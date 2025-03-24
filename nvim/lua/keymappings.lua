--print("hello from keymappings.lua")
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Turn off search highlight
map("n", "<Esc><Esc>", ":silent! nohls<CR>", opts)

-- List and switch buffers
map("", "<leader>b", ":ls<CR>:b<Space>", { noremap = true })

-- Edit vim config
map("n", "<leader>ev", ":vsplit $MYVIMRC<CR>", opts)

-- Uppercase current word
map("n", "<leader>u", "viwUe", { noremap = true })

-- Window navigation
map("n", "<C-J>", "<C-W><C-J>", { noremap = true })
map("n", "<C-K>", "<C-W><C-K>", { noremap = true })
map("n", "<C-L>", "<C-W><C-L>", { noremap = true })
map("n", "<C-H>", "<C-W><C-H>", { noremap = true })

-- Tab management
map("n", "<C-N>", ":tabnew<CR>", opts)
map("n", "<C-Up>", ":tabprevious<CR>", opts)
map("n", "<C-Down>", ":tabnext<CR>", opts)

-- Popup menu navigation
vim.keymap.set("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true })
vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true })

-- Close buffer
map("n", "<leader>q", ":q<CR>", opts)

-- Source vimrc
map("n", "<leader><leader>s", ":source $MYVIMRC<CR>", opts)

-- Buffer navigation
map("", "<S-L>", ":bnext<CR>", { noremap = true })
map("", "<S-H>", ":bprev<CR>", { noremap = true })

-- LSP Finder (Lspsaga)
map("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
map("n", "gh", ":Lspsaga lsp_finder<CR>", opts) -- Optional alternative

-- Code Action
map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
map("v", "<leader>ca", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
map("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", opts)

-- Toggle cursor column
map("n", "<Leader>c", ":set cursorcolumn!<CR>", opts)

-- Neotree plugin
map("n", "<C-Z>", ":Neotree toggle<CR>", opts)
vim.keymap.set("n", "<leader>gg", "<cmd>Neotree toggle git_status<cr>", { desc = "Toggle Git Status (Neo-tree)" })

-- Floaterm toggle
map("n", "<leader>ft", ":FloatermNew<CR>", opts)
map("t", "<leader>ft", "<C-\\><C-n>:FloatermNew<CR>", opts)
-- Go to tab by tab number
vim.api.nvim_set_keymap("n", "<leader>1", "1gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>2", "2gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>3", "3gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>4", "4gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>5", "5gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>6", "6gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>7", "7gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>8", "8gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>9", "9gt", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>0", ":tablast<cr>", { noremap = true })

-- Find files using Telescope command-line.
vim.api.nvim_set_keymap("n", "<leader>ff", ':lua require("telescope.builtin").find_files()<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ':lua require("telescope.builtin").live_grep()<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ':lua require("telescope.builtin").buffers()<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", ':lua require("telescope.builtin").help_tags()<cr>', { noremap = true })

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
