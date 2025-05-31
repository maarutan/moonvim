local snacks = require("snacks")

local items = {
	{ text = "Опция 1 ", file = "/path/to/file1" },
	{ text = "Опция 2 ", file = "/path/to/file2" },
	-- добавь свои элементы
}

snacks
	.picker({
		title = "Выбор опции",
		items = items,
		format = function(item)
			return {
				{ item.text, "SnacksPickerLabel" },
				{ item.name, "SnacksPickerComment" },
			}
		end,
		confirm = function(picker, item)
			picker:close()
			-- обработка выбора
			print("Вы выбрали: " .. item.name)
		end,
	})
	:find()
