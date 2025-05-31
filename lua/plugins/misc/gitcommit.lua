local StylizedText = require("plugins.misc.stylized_text")

local function get_git_info()
	local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
	if git_dir == "" then
		return nil
	end

	local function safe_popen(cmd)
		local handle = io.popen(cmd)
		if not handle then
			return ""
		end
		local result = handle:read("*a") or ""
		handle:close()
		return vim.trim(result)
	end

	local url = safe_popen("git config --get remote.origin.url")
	local count = safe_popen("git rev-list --count HEAD")
	local branch = safe_popen("git rev-parse --abbrev-ref HEAD")

	if url == "" then
		return nil
	end

	local name = url:match("([^/]+)%.git$") or url:match("([^/]+)$") or "unknown"

	local host = "git"
	if url:match("github%.com") then
		host = "github"
	elseif url:match("gitlab%.com") then
		host = "gitlab"
	elseif url:match("aur%.archlinux%.org") then
		host = "aur"
	elseif url:match("bitbucket%.org") then
		host = "bitbucket"
	elseif url:match("sourceforge%.net") then
		host = "sourceforge"
	elseif url:match("azure%.com") then
		host = "azure"
	elseif url:match("gitkraken%.com") then
		host = "gitkraken"
	elseif url:match("aws%.amazon%.com") then
		host = "aws"
	end

	local clouds = {
		aur = "󰣇",
		github = "",
		gitlab = "",
		bitbucket = "",
		sourceforge = "󱠇",
		azure = "",
		gitkraken = "",
		aws = "",
		git = "󰊢",
	}

	return {
		url = url,
		branch = branch,
		name = name,
		host = host,
		icon = clouds[host] or "󰊢",
		commit_count = count,
	}
end

local function insert_stylized_header(project_name, commit_label, git_info)
	local lines = {}

	-- Top ASCII art
	local top_art = StylizedText:new(project_name):render()
	for line in top_art:gmatch("[^\n]+") do
		table.insert(lines, "# " .. line)
	end
	table.insert(lines, "#------------------------------------------------------------")

	-- Git metadata
	if git_info then
		table.insert(lines, "#  repo : " .. git_info.url)
		table.insert(lines, "#  branch: " .. git_info.branch)
		table.insert(lines, "#  commits: " .. git_info.commit_count)
		table.insert(lines, "# " .. git_info.icon .. " " .. git_info.name)
	end

	table.insert(lines, "# --------------------------------")
	local cursor_line = #lines + 1
	table.insert(lines, "")
	-- table.insert(lines, "# --------------------------------")

	-- Bottom ASCII art (e.g., "git commit")
	table.insert(lines, "#--------------------------------------------------------------")
	local commit_art = StylizedText:new(commit_label):render()
	for line in commit_art:gmatch("[^\n]+") do
		table.insert(lines, "# " .. line)
	end

	-- Inject into buffer
	vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
	vim.api.nvim_win_set_cursor(0, { cursor_line, 0 })
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		if vim.b.stylized_header_inserted then
			return
		end
		vim.b.stylized_header_inserted = true

		local info = get_git_info()
		local project_name = info and info.name or "project"
		insert_stylized_header(project_name, "git commit", info)
		vim.cmd("startinsert")
	end,
})
