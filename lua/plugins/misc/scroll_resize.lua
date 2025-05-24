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
	return current_line == total_lines
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

function M.up()
	local scroll = Scroll.new(M.config.scroll.move, M.config.scroll.repeat_interval, M.config.scroll.jump)
	scroll:run("k")
end

function M.down()
	local scroll = Scroll.new(M.config.scroll.move, M.config.scroll.repeat_interval, M.config.scroll.jump)
	scroll:run("j")
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
end

return M.setup({})
