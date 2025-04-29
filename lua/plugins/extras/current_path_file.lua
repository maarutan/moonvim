local M = {}

local last_notification_id = nil
local timeout = 3000

function notifysend(message, title, replace, timeout)
  last_notification_id = vim.notify(message, vim.log.levels.WARN, {
    title = title,
    replace = replace,
    timeout = timeout,
  })
end

function M.show_file_path(copy)
	local file_path = vim.fn.expand("%:p")
	if file_path == "" then
		file_path = "File doesn't exist"
	else
		file_path = file_path:gsub(vim.env.HOME, "~")
	end

  if copy then
    vim.fn.setreg('+', file_path)
    notifysend(
      file_path,
      "Copy File Path 🚀",
      last_notification_id,
      timeout
    )
  end
  notifysend(
    file_path,
    "Current File Path 🚀",
    last_notification_id,
    timeout
  )
end

return M

