-- lua/langs/py.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "python",
    indent      = 4,
    colorcolumn = "80",
    makeprg     = "python3 %",
    errorformat = [[%E  File "%f", line %l,%C%p^,%Z%m,%-G%.%#]],
    style_hint = "python: remember to use snake_case.",
  }
end

return M
