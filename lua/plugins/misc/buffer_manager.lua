local M = {}

---@class BufferManager
local BufferManager = {}
BufferManager.__index = BufferManager

function BufferManager.new()
	local obj = setmetatable({}, BufferManager)
	return obj
end

function BufferManager:input(pleaseHolder)
	return vim.fn.input(pleaseHolder)
end

function BufferManager:notify(icon, status, time, message)
	time = time or 3000

	local status_map = {
		e = "error",
		error = "error",
		i = "info",
		info = "info",
		w = "warn",
		warn = "warn",
	}

	local key = status_map[status]
	if not key then
		vim.notify("Unknown status: " .. tostring(status), vim.log.levels.WARN)
		return
	end

	local level_map = {
		error = vim.log.levels.ERROR,
		info = vim.log.levels.INFO,
		warn = vim.log.levels.WARN,
	}

	local opts = {
		title = "BufferManager",
		timeout = time,
	}

	if icon then
		opts.icon = icon
	end

	vim.notify(message, level_map[key], opts)
end

function BufferManager:buffer_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local ext = vim.fn.fnamemodify(bufname, ":e")
	local buftype = vim.api.nvim_buf_get_option(0, "buftype")
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
	local modified = vim.bo[bufnr].modifiable
	local readonly = vim.bo[bufnr].readonly
	self:notify(
		"ℹ️",
		"warn",
		10000,
		string.format(
			"bufnr: %s\nbufname: %s\nbuftype: %s\nfiletype: %s\nmodified: %s\nreadonly: %s\next: %s",
			bufnr,
			bufname,
			buftype,
			filetype,
			modified,
			readonly,
			ext
		)
	)
end

function BufferManager:create_new_buffer()
	local name = self:input("✍️ new buffer name:")
	if name == "" or name == nil then
		return
	else
		vim.cmd("edit " .. name)
		vim.cmd("write " .. name)
		self:buffer_info()
	end
end

function BufferManager:delete_force()
	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	local filepath = vim.api.nvim_buf_get_name(0)
	vim.fn.delete(filepath)
	self:notify("💀", "w", 5000, filename .. "Deleted")
end

function BufferManager:Bdelete(buffers, force, switchable_buffers)
	local api = vim.api
	local cmd = vim.cmd
	local fn = vim.fn
	local bo = vim.bo

	local function bufname(bufnr)
		local name = api.nvim_buf_get_name(bufnr)
		return name ~= "" and name or "[No Name]"
	end

	local function char_prompt(text, choices)
		local choice = fn.confirm(text, table.concat(choices, "\n"), "", "Q")
		return choice == 0 and "C" or string.match(choices[choice], "&?(%a)")
	end

	local function get_buffer_handle(buffer_or_pat)
		local bufnr
		if buffer_or_pat == nil then
			bufnr = 0
		elseif type(buffer_or_pat) == "number" then
			bufnr = buffer_or_pat
		elseif type(buffer_or_pat) == "string" then
			bufnr = tonumber(buffer_or_pat) or nil
			if not bufnr then
				for _, b in ipairs(api.nvim_list_bufs()) do
					if api.nvim_buf_is_valid(b) and api.nvim_buf_get_name(b):match(buffer_or_pat) then
						bufnr = b
						break
					end
				end
			end
		end
		return bufnr == 0 and api.nvim_get_current_buf() or bufnr
	end

	local function get_target_buffers(buffers)
		if type(buffers) ~= "table" then
			return { get_buffer_handle(buffers) }
		end
		local out = {}
		for _, v in ipairs(buffers) do
			local bufnr = get_buffer_handle(v)
			if bufnr ~= nil then
				table.insert(out, bufnr)
			end
		end
		return out
	end

	local function buf_kill(target_buffers, switchable_buffers, force)
		local buf_is_deleted = {}
		for _, v in ipairs(target_buffers) do
			buf_is_deleted[v] = true
		end

		if not force then
			for bufnr in pairs(buf_is_deleted) do
				if bo[bufnr].modified then
					local choice = char_prompt(
						string.format("No write since last change for buffer %d (%s).", bufnr, bufname(bufnr)),
						{ "&Save", "&Ignore", "&Cancel" }
					)
					if choice == "s" or choice == "S" then
						api.nvim_buf_call(bufnr, function()
							cmd.write()
						end)
					elseif choice ~= "i" and choice ~= "I" then
						buf_is_deleted[bufnr] = nil
					end
				elseif bo[bufnr].buftype == "terminal" and fn.jobwait({ bo[bufnr].channel }, 0)[1] == -1 then
					local choice = char_prompt(
						string.format("Terminal buffer %d (%s) is still running.", bufnr, bufname(bufnr)),
						{ "&Ignore", "&Cancel" }
					)
					if choice ~= "i" and choice ~= "I" then
						buf_is_deleted[bufnr] = nil
					end
				end
			end
		end

		if next(buf_is_deleted) == nil then
			api.nvim_err_writeln("No buffers were deleted")
			return
		end

		local windows = vim.tbl_filter(function(win)
			return buf_is_deleted[api.nvim_win_get_buf(win)]
		end, api.nvim_list_wins())

		if not switchable_buffers then
			switchable_buffers = vim.tbl_filter(function(buf)
				return api.nvim_buf_is_valid(buf) and bo[buf].buflisted and not buf_is_deleted[buf]
			end, api.nvim_list_bufs())
		end

		local switch_bufnr
		if #switchable_buffers > 0 then
			local latest = -1
			for _, b in ipairs(switchable_buffers) do
				local info = fn.getbufinfo(b)[1]
				if info.lastused > latest then
					switch_bufnr = b
					latest = info.lastused
				end
			end
		else
			switch_bufnr = api.nvim_create_buf(true, false)
		end

		for _, win in ipairs(windows) do
			api.nvim_win_set_buf(win, switch_bufnr)
		end

		for bufnr in pairs(buf_is_deleted) do
			if api.nvim_buf_is_loaded(bufnr) then
				local use_force = force or bo[bufnr].modified or bo[bufnr].buftype == "terminal"
				api.nvim_exec_autocmds("User", { pattern = "BDeletePre " .. bufnr })
				cmd.bdelete({ count = bufnr, bang = use_force })
				api.nvim_exec_autocmds("User", { pattern = "BDeletePost " .. bufnr })
			end
		end
	end

	buf_kill(get_target_buffers(buffers), switchable_buffers, force)
end

-- ---@param user_config table
-- function M.setup(user_config)
-- 	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
--
-- end

local buffer_manager = BufferManager.new()

vim.api.nvim_create_user_command("BDeleteFile", function()
	buffer_manager:delete_force()
end, {})

vim.api.nvim_create_user_command("BCreateFile", function()
	buffer_manager:create_new_buffer()
end, {})

vim.api.nvim_create_user_command("BDelete", function()
	buffer_manager:Bdelete()
end, {})

return M
