-- local function witch(command)
-- 	return vim.fn.executable(command) == 1
-- end
--
-- local function is_directory(path)
-- 	local handle = io.popen('stat -c %F "' .. path:gsub('"', '\\"') .. '" 2>/dev/null')
-- 	local result = handle:read("*a")
-- 	handle:close()
-- 	result = result:gsub("%s+", "")
-- 	return result == "directory"
-- end
--
-- local function is_file(path)
-- 	local handle = io.popen('stat -c %F "' .. path:gsub('"', '\\"') .. '" 2>/dev/null')
-- 	local result = handle:read("*a")
-- 	handle:close()
-- 	result = result:gsub("%s+", "")
-- 	return result == "regularfile"
-- end
--
-- local function restore()
-- 	if witch("trash-restore") then
-- 		local handle = io.popen("trash-restore < /dev/null")
-- 		local result = handle:read("*a")
-- 		handle:close()
--
-- 		local max_index = -1
-- 		local max_line = nil
--
-- 		for line in result:gmatch("[^\r\n]+") do
-- 			local index = line:match("^%s*(%d+)")
-- 			if index then
-- 				index = tonumber(index)
-- 				if index > max_index then
-- 					max_index = index
-- 					max_line = line
-- 				end
-- 			end
-- 		end
--
-- 		local function extract_name_and_path(line)
-- 			local path = line:match("(%S+)$")
-- 			local name = path and path:match("([^/]+)$") or nil
-- 			return name, path
-- 		end
--
-- 		local filename, filepath = extract_name_and_path(max_line)
--
-- 		os.execute("echo " .. max_index .. " | trash-restore")
-- 		print(max_index)
--
-- 		local desc_filetype
-- 		if is_directory(filepath) then
-- 			desc_filetype = "Directory 📂"
-- 		elseif is_file(filepath) then
-- 			desc_filetype = "File 📄"
-- 		else
-- 			desc_filetype = "Undefined 🤷"
-- 		end
--
-- 		vim.notify(
-- 			string.format("filename: %s\nfiletype: %s\nfilepath: %s", filename, desc_filetype, filepath),
-- 			vim.log.levels.WARN,
-- 			{
-- 				icon = "👽",
-- 				title = "Restore",
-- 				time = 10000,
-- 			}
-- 		)
-- 	else
-- 		vim.notify("`trash-cli`: no found", vim.log.levels.WARN, { icon = "🚮" })
-- 		return
-- 	end
-- end
--
-- restore()

local function get_latest_trashed_file()
	local handle = io.popen("trash-restore  < /dev/null")
	local result = handle:read("*a")
	handle:close()

	local max_index = -1
	local max_line = nil
	print(result)
	print(handle)
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
		local path = line and line:match("(%S+)$")
		local name = path and path:match("([^/]+)$") or nil
		return name, path
	end

	local filename, filepath = extract_name_and_path(max_line)

	return max_index, filename, filepath
end

get_latest_trashed_file()
-- print(get_latest_trashed_file())
