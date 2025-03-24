print("✅ Loaded config/neoformat.lua")
-- Neoformat global settings
vim.g.neoformat_try_formatprg = 1
vim.g.neoformat_run_all_formatters = 1
vim.g.neoformat_verbose = 0

-- Enable specific formatters per filetype
vim.g.neoformat_enabled_javascript = { "prettier", "eslint_d" }
vim.g.neoformat_enabled_python = { "autopep8", "yapf", "docformatter" }
vim.g.neoformat_enabled_css = { "prettier" }
vim.g.neoformat_enabled_yaml = { "prettier" }
vim.g.neoformat_enabled_lua = { "stylua" }

-- Auto format on save with fallback
vim.api.nvim_create_augroup("fmt", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = "fmt",
  pattern = "*",
  callback = function()
    -- Try to format with undo support and fallback silently
    local success, _ = pcall(function()
      vim.cmd("undojoin")
      vim.cmd("Neoformat")
    end)
    if not success then
      pcall(vim.cmd, "silent Neoformat")
    end
  end,
})