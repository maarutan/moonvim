local M = {}

local function path_quote(path)
	return "'" .. string.gsub(path, "'", "'\\''") .. "'"
end

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "TrashRestore" })
end

function M.get_volume()
	local handle = io.popen("trash-list --volumes")
	if not handle then
		notify("Не удалось выполнить `trash-list --volumes`", vim.log.levels.ERROR)
		return nil
	end

	local volumes = handle:read("*a")
	handle:close()

	local cwd = vim.fn.getcwd()
	local best_match = nil
	local best_len = 0

	for vol in volumes:gmatch("[^\r\n]+") do
		if cwd:sub(1, #vol) == vol and #vol > best_len then
			best_match = vol
			best_len = #vol
		end
	end

	if not best_match then
		notify("Не удалось найти подходящий том корзины", vim.log.levels.ERROR)
	end
	return best_match
end

function M.list_trashed(volume)
	local cmd = string.format("printf '\\n' | trash-restore %s", path_quote(volume))
	local handle = io.popen(cmd)
	if not handle then
		notify("Не удалось выполнить `trash-restore`", vim.log.levels.ERROR)
		return nil
	end

	local output = handle:read("*a")
	handle:close()

	local items = {}
	for line in output:gmatch("[^\r\n]+") do
		local index, date, time, path = line:match("^(%d+)%s+(%S+)%s+(%S+)%s+(.+)$")
		if index and date and path then
			table.insert(items, {
				index = tonumber(index),
				datetime = date .. " " .. time,
				path = path,
			})
		end
	end

	return items
end

function M.restore(volume, start_idx, end_idx)
	local cmd = string.format("echo '%d-%d' | trash-restore --overwrite %s", start_idx, end_idx, path_quote(volume))
	local ok = os.execute(cmd)
	if ok then
		notify(string.format("Восстановлено %d файл(ов)", end_idx - start_idx + 1))
	else
		notify("Ошибка при восстановлении", vim.log.levels.ERROR)
	end
end

local trash = require("trash_restore")
local vol = trash.get_volume()
if vol then
	local items = trash.list_trashed(vol)
	for _, item in ipairs(items) do
		print(string.format("[%d] %s — %s", item.index, item.datetime, item.path))
	end
end

return M
