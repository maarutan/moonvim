local inp = function(prompt, callback)
	local input = vim.fn.inputsecret(prompt)
	if input == nil or input == "" then
		print("Input cancelled")
	else
		callback(input)
	end
end

local function current_buffer()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	return table.concat(lines, "\n")
end

local function sudo_write()
	local abs_path = vim.fn.expand("%:p")
	local max_attempts = 1
	local attempts = 0

	-- Просто синхронный ввод пароля
	local password = vim.fn.inputsecret("Password: ")
	if not password or password == "" then
		vim.notify("Пароль не введён", vim.log.levels.ERROR)
		return
	end

	local content = current_buffer()
	local tmpname = vim.fn.tempname()

	local f = io.open(tmpname, "w")
	if not f then
		vim.notify("Не удалось создать временный файл", vim.log.levels.ERROR)
		return
	end
	f:write(content)
	f:close()

	-- Выполнение с sudo -S
	local cmd = string.format("sudo -S tee '%s' < '%s' > /dev/null", abs_path, tmpname)
	local result = vim.fn.system(cmd, password .. "\n")

	os.remove(tmpname)

	if vim.v.shell_error == 0 then
		vim.cmd("edit!")
		vim.cmd("normal! zz")
		vim.notify("Файл сохранён с sudo", vim.log.levels.INFO)
	else
		vim.notify("Ошибка при сохранении через sudo:\n" .. result, vim.log.levels.ERROR)
	end
end

-- Вызов
sudo_write()
