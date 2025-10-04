-- lua/auto_reload.lua
local M = {}
local uv = vim.uv or vim.loop
local watchers = {}
local dir_watcher

local defaults = {
	project_watch = false, -- watch the whole repo (good for atomic writes)
	recursive = true, -- macOS/Windows support recursive; Linux ignores
	notify = true, -- echo a message after reload
	autoread = true,
	backupcopy = "yes",
	confirm = true,
}

local function echo(msg, hl)
	if not M.opts.notify then
		return
	end
	vim.api.nvim_echo({ { msg, hl or "WarningMsg" } }, false, {})
end

local function checktime_all()
	vim.cmd("checktime")
	echo("↻ Reloaded changed files")
end

local function watch_buf(bufnr)
	if watchers[bufnr] then
		return
	end
	
	vim.schedule(function()
		if not vim.api.nvim_buf_is_loaded(bufnr) then
			return
		end
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name == "" then
			return
		end
		if not uv.fs_stat(name) then
			return
		end

		local h = uv.new_fs_event()
		if not h then
			return
		end
		h:start(
			name,
			{},
			vim.schedule_wrap(function(err)
				if err then
					return
				end
				-- now we're on the main loop; it's safe to use nvim API
				if
					vim.api.nvim_buf_is_valid(bufnr)
					and vim.api.nvim_buf_is_loaded(bufnr)
					and not vim.api.nvim_buf_get_option(bufnr, "modified")
					and vim.api.nvim_buf_get_name(bufnr) == name
				then
					checktime_all()
				end
			end)
		)
		watchers[bufnr] = h

		vim.api.nvim_create_autocmd({ "BufUnload", "BufWipeout" }, {
			buffer = bufnr,
			once = true,
			callback = function()
				if watchers[bufnr] then
					watchers[bufnr]:stop()
					watchers[bufnr]:close()
					watchers[bufnr] = nil
				end
			end,
		})
	end)
end

local function project_root()
	local git = vim.fs.find(".git", { upward = true, type = "directory" })[1]
	return git and vim.fs.dirname(git) or uv.cwd()
end

local function start_project_watch()
	if dir_watcher then
		return
	end
	dir_watcher = uv.new_fs_event()
	if not dir_watcher then
		return
	end
	dir_watcher:start(project_root(), { recursive = M.opts.recursive }, function(err)
		if err then
			return
		end
		vim.schedule(checktime_all)
	end)
end

local function stop_project_watch()
	if dir_watcher then
		dir_watcher:stop()
		dir_watcher:close()
		dir_watcher = nil
	end
end

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", defaults, opts or {})

	if M.opts.autoread then
		vim.o.autoread = true
	end
	vim.o.backupcopy = M.opts.backupcopy
	vim.o.confirm = M.opts.confirm

	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		callback = function(a)
			watch_buf(a.buf)
		end,
	})

	vim.api.nvim_create_autocmd("FileChangedShellPost", {
		callback = function()
			echo("↻ Reloaded: file changed on disk")
		end,
	})

	if M.opts.project_watch then
		start_project_watch()
	end

	vim.api.nvim_create_user_command("AutoReloadEnable", function()
		M.opts.project_watch = true
		start_project_watch()
		echo("AutoReload project watch enabled", "MoreMsg")
	end, {})

	vim.api.nvim_create_user_command("AutoReloadDisable", function()
		M.opts.project_watch = false
		stop_project_watch()
		echo("AutoReload project watch disabled", "MoreMsg")
	end, {})

	vim.api.nvim_create_user_command("AutoReloadCheck", function()
		checktime_all()
	end, {})
end

return M
