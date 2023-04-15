local M = {
	"karb94/neoscroll.nvim",
	opts = {
		mappings = { "<C-u>", "<C-d>" },
		hide_cursor = false, -- Hide cursor while scrolling
		stop_eof = false, -- Stop at <EOF> when scrolling downwards
		respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
		cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	},
}

return M
