require("nvim-surround").setup()

-- Don't alter indent after edit
require("nvim-surround.buffer").format_lines = function(_, _) end
