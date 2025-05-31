local StylizedText = {}
StylizedText.__index = StylizedText

function StylizedText:new(content)
	content = content or "Enter content"
	local fonts = self:_fonts()
	local font = fonts["calvin_s"]
	if not font then
		error("Font 'calvin_s' not found.")
	end
	local obj = {
		font = font,
		content = content,
	}
	setmetatable(obj, self)
	return obj
end

function StylizedText:_fonts()
	return {
		calvin_s = {
			a = "┌─┐\n├─┤\n┴ ┴",
			b = "┌┐ \n├┴┐\n└─┘",
			c = "┌─┐\n│  \n└─┘",
			d = "┌┬┐\n ││\n─┴┘",
			e = "┌─┐\n├─ \n└─┘",
			f = "┌─┐\n├┤ \n└  ",
			g = "┌─┐\n│ ┬\n└─┘",
			h = "┬ ┬\n├─┤\n┴ ┴",
			i = "┬\n│\n┴",
			j = " ┬\n │\n└┘",
			k = "┬┌─\n├┴┐\n┴ ┴",
			l = "┬  \n│  \n┴─┘",
			m = "┌┬┐\n│││\n┴ ┴",
			n = "┌┐┌\n│││\n┘└┘",
			o = "┌─┐\n│ │\n└─┘",
			p = "┌─┐\n├─┘\n┴  ",
			q = "┌─┐ \n│─┼┐\n└─┘└",
			r = "┬─┐\n├┬┘\n┴└─",
			s = "┌─┐\n└─┐\n└─┘",
			t = "┌┬┐\n │ \n ┴ ",
			u = "┬ ┬\n│ │\n└─┘",
			v = "┬  ┬\n└┐┌┘\n └┘ ",
			w = "┬ ┬\n│││\n└┴┘",
			x = "─┐ ┬\n┌┴┬┘\n┴ └─",
			y = "┬ ┬\n└┬┘\n ┴ ",
			z = "┌─┐\n┌─┘\n└─┘",
		},
	}
end

function StylizedText:render()
	local lines = { "", "", "" }
	for c in self.content:lower():gmatch(".") do
		local char_art = self.font[c] or "   \n   \n   "
		local char_lines = {}
		for line in char_art:gmatch("[^\n]+") do
			table.insert(char_lines, line)
		end
		for i = 1, 3 do
			lines[i] = lines[i] .. (char_lines[i] or "   ")
		end
	end
	return table.concat(lines, "\n")
end

function StylizedText:__tostring()
	local ok, result = pcall(function()
		return self:render()
	end)
	if not ok then
		return "Error: no valid font"
	end
	return result
end

_G.StylizedText = StylizedText
return StylizedText
