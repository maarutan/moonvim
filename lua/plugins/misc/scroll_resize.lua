local M = {}

---@scroll table
---@rezize table

---@repeat_interval number
---@key table
---@move number
---@jump number

M.config = {
	scroll = {
		repeat_interval = 30,
		jump = 1,
		move = 5,
	},
	go_to = {
		repeat_interval = 9,
		jump = 3,
	},
}

---@class Scroll
local Scroll = {}
Scroll.__index = Scroll

function Scroll.new(move, repeat_interval, jump)
	local obj = setmetatable({}, Scroll)
	obj.repeat_interval = repeat_interval
	obj.move = move
	obj.jump = jump
	return obj
end

---@return boolean
function Scroll:is_cursor_bottom()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)
	return current_line >= total_lines
end

---@return boolean
function Scroll:is_cursor_top()
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	return cursor_line == 1
end

---@return Scroll
function Scroll:run(key)
	local counter = 0
	local timer = vim.loop.new_timer()

	timer:start(
		0,
		self.repeat_interval,
		vim.schedule_wrap(function()
			counter = counter + 1
			vim.cmd("normal! " .. self.jump .. key)
			if self:is_cursor_bottom() then
				vim.cmd(vim.api.nvim_replace_termcodes("normal! <C-e>", true, true, true))
			end
			if counter == self.move then
				timer:stop()
				timer:close()
			end
		end)
	)

	return self
end

---@return Scroll
function Scroll:GoTo(status, key)
	local timer = vim.loop.new_timer()
	local is_self_trigger = false

	local function stop_all()
		if timer then
			timer:stop()
			timer:close()
			timer = nil
		end
		if self._key_unmap then
			vim.on_key(nil, self._key_unmap)
			self._key_unmap = nil
		end
	end

	-- Слушатель ввода: любое нажатие пользователя — стоп
	self._key_unmap = vim.on_key(function()
		if not is_self_trigger then
			stop_all()
		end
	end, vim.api.nvim_create_namespace("ScrollStopper"))

	timer:start(
		0,
		self.repeat_interval,
		vim.schedule_wrap(function()
			-- Отметка, что это наше нажатие
			is_self_trigger = true
			vim.cmd("normal! " .. self.jump .. key)
			is_self_trigger = false

			-- Проверка на достижение верха или низа
			if status == "up" and self:is_cursor_top() then
				stop_all()
			elseif status == "down" and self:is_cursor_bottom() then
				stop_all()
			end
		end)
	)

	return self
end

function M.up()
	local scroll = Scroll.new(M.config.scroll.move, M.config.scroll.repeat_interval, M.config.scroll.jump)
	scroll:run("k")
end

function M.down()
	local scroll = Scroll.new(M.config.scroll.move, M.config.scroll.repeat_interval, M.config.scroll.jump)
	scroll:run("j")
end

function M.go_to_up()
	local scroll = Scroll.new(M.config.scroll.move, M.config.go_to.repeat_interval, M.config.go_to.jump)
	scroll:GoTo("up", "k")
end

function M.go_to_bottom()
	local scroll = Scroll.new(M.config.scroll.move, M.config.go_to.repeat_interval, M.config.go_to.jump)
	scroll:GoTo("down", "j")
end

local Resize = {}
Resize.__index = Resize

function Resize.new()
	local obj = setmetatable({}, Resize)
	return obj
end

function Resize:run(direction, size, delay)
	local counter = 0
	local timer = vim.loop.new_timer()
	delay = tonumber(delay) or 0

	if type(size) ~= "string" then
		size = tostring(size)
	end

	if not size:match("^[+-]?%d+$") then
		vim.notify("Invalid size argument: " .. size, vim.log.levels.ERROR)
		return
	end

	timer:start(
		0,
		delay,
		vim.schedule_wrap(function()
			counter = counter + 1
			local cmd = (direction == "vertical" and "vertical resize " or "resize ") .. size
			vim.cmd(cmd)

			if counter == 5 then
				timer:stop()
				timer:close()
			end
		end)
	)
end

---@param user_config table
function M.setup(user_config)
	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

	_G.Resize = {
		hor = function(size, delay)
			local resize = Resize.new()
			resize:run("", size, delay)
		end,
		ver = function(size, delay)
			local resize = Resize.new()
			resize:run("vertical", size, delay)
		end,
	}

	vim.api.nvim_create_user_command("ScrollUp", M.up, {})
	vim.api.nvim_create_user_command("ScrollDown", M.down, {})

	vim.api.nvim_create_user_command("GoToUp", M.go_to_up, {})
	vim.api.nvim_create_user_command("GoToBottom", M.go_to_bottom, {})
end

return M.setup({})
