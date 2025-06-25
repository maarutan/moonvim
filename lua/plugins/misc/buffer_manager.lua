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

function BufferManager:witch(command)
	return vim.fn.executable(command) == 1
end

function BufferManager:delete_file()
	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	local filepath = vim.api.nvim_buf_get_name(0)
	local msg = string.format("-- (y/N) -- you want to trash  '%s' ???", filename)
	local input = self:input(msg)
	if input == "y" or input == "Y" then
		vim.fn.delete(filepath)
		self:notify("🔪💀", "w", 5000, "==> ```" .. filename .. "```: \n ---->  deleted by `trash-put`")
		self:bdelete()
	else
		return nil
	end
end

function BufferManager:input_handler_ask(default_is_yes, message, func_true, func_false)
	func_true = func_true or function() end
	func_false = func_false or function() end

	local default_yes = default_is_yes == "yes" or default_is_yes == "y" or default_is_yes == true
	local suffix = default_yes and "[Y/n]" or "[y/N]"
	local prompt = string.format("%s %s: ", message, suffix)

	vim.fn.inputsave()
	local input = self:input(prompt)

	vim.fn.inputrestore()

	input = input:lower()

	if input == "" then
		if default_yes then
			return func_true()
		else
			return func_false()
		end
	end

	if input == "y" or input == "yes" then
		return func_true()
	elseif input == "n" or input == "no" then
		return func_false()
	else
		return self:input_handler_ask(default_is_yes, message, func_true, func_false)
	end
end

function BufferManager:move_to_trash()
	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	local filepath = vim.api.nvim_buf_get_name(0)
	local msg = string.format("you want to trash  '%s' ???", filename)

	self:input_handler_ask("no", msg, function()
		if BufferManager:witch("trash-put") then
			vim.fn.system("trash-put " .. vim.fn.fnameescape(filepath))
			self:notify("🔪💀", "w", 5000, "==> ```" .. filename .. "```: \n ---->  deleted by `trash-put`")
			self:bdelete()
		else
			self:notify("🚮", "w", 5000, "`trash-cli`: not found")
		end
	end, function()
		self:notify("❌", "i", 2000, "Cancelled trashing `" .. filename .. "`")
	end)
end

function BufferManager:is_directory(path)
	local handle = io.popen('stat -c %F "' .. path:gsub('"', '\\"') .. '" 2>/dev/null')
	local result = handle:read("*a")
	handle:close()
	result = result:gsub("%s+", "")
	return result == "directory"
end

function BufferManager:is_file(path)
	local handle = io.popen('stat -c %F "' .. path:gsub('"', '\\"') .. '" 2>/dev/null')
	local result = handle:read("*a")
	handle:close()
	result = result:gsub("%s+", "")
	return result == "regularfile"
end

function BufferManager:restore()
	if self:witch("trash-restore") then
		local handle = io.popen("trash-restore < /dev/null")
		local result = handle:read("*a")
		handle:close()

		local max_index = -1
		local max_line = nil

		for line in result:gmatch("[^\r\n]+") do
			local index = line:match("^%s*(%d+)")
			if index then
				index = tonumber(index)
				if index > max_index then
					max_index = index
					max_line = line
				end
			end
		end

		local function extract_name_and_path(line)
			local path = line:match("(%S+)$")
			local name = path and path:match("([^/]+)$") or nil
			return name, path
		end

		local filename, filepath = extract_name_and_path(max_line)

		vim.fn.system("echo " .. tostring(max_index) .. " | trash-restore")

		local desc_filetype
		if self:is_directory(filepath) then
			desc_filetype = "Directory 📂"
		elseif self:is_file(filepath) then
			desc_filetype = "File 📄"
		else
			desc_filetype = "Undefined 🤷"
		end

		vim.notify(
			string.format("filename: %s\nfiletype: %s\nfilepath: %s", filename, desc_filetype, filepath),
			vim.log.levels.WARN,
			{
				icon = "👽",
				title = "Restore",
				time = 10000,
			}
		)
	else
		vim.notify("`trash-cli`: no found", vim.log.levels.WARN, { icon = "🚮" })
		return
	end
end

function BufferManager:bdelete(buffers, force, switchable_buffers)
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

local buffer_manager = BufferManager.new()

local user_command = function(commands)
	for _, cmd in ipairs(commands) do
		local name = cmd[1]
		local func = cmd[2]
		vim.api.nvim_create_user_command(name, function()
			func()
		end, {})
	end
end

function add_in_global(functions)
	_G.buffermanager = _G.buffermanager or {}

	for name, func in pairs(functions) do
		_G.buffermanager[name] = func
	end
end

user_command({
	{
		"BDelete",
		function()
			buffer_manager:bdelete()
		end,
	},
	{
		"BTrash",
		function()
			buffer_manager:move_to_trash()
		end,
	},
	{
		"BDeleteFile",
		function()
			buffer_manager:delete_file()
		end,
	},
	{
		"BCreateFile",
		function()
			buffer_manager:create_new_buffer()
		end,
	},
	{
		"BRestore",
		function()
			buffer_manager:restore()
		end,
	},
})

add_in_global({
	input = function(...)
		return buffer_manager:input(...)
	end,
	notify = function(...)
		return buffer_manager:notify(...)
	end,
})

return M
