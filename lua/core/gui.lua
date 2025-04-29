-- ┌─┐┬ ┬┬  ┌┐┌┌─┐┌─┐┬  ┬┬┌┬┐┌─┐
-- │ ┬│ ││  │││├┤ │ │└┐┌┘│ ││├┤ 
-- └─┘└─┘┴  ┘└┘└─┘└─┘ └┘ ┴─┴┘└─┘
-- Copyright (c) 2025 maarutan. \ Marat Arzymatov  All Rights Reserved.
-------------------------------------------------------------------------

vim.o.guifont = "JetBrainsMono Nerd Font:h11:sp2"  -- Set the default font

vim.o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon800-blinkoff600-blinkwait500," -- cursor shape
	.. "i-ci-ve:ver25-CursorInsert/lCursor-blinkon800-blinkoff600-blinkwait500,"
	.. "r-cr:hor20-CursorReplace/lCursor-blinkon800-blinkoff600-blinkwait500"

vim.g.neovide_hide_mouse_when_typing = true -- Hide the mouse cursor when typing
vim.g.neovide_scale_factor = 1.0 -- Default scale factor

vim.g.neovide_transparency = 1.0 -- Default transparency

vim.g.neovide_input_use_logo = true -- Use the logo key as the Meta key
vim.g.neovide_scroll_animation_length = 0.6 -- Scroll animation speed
vim.o.termguicolors = true -- Enable true color support

-- keymaps
local bind = vim.keymap.set
bind("n", "<C-S-=>", function()   -- Increase font size
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end
bind("n", "<C-S-->", function()  -- Decrease font size
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
end

bind("n", "<F11>", function() -- toggle fullscreen
	vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen 
end
