-- lua/langs/html.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "html",
    indent      = 2,
    colorcolumn = "100",
    makeprg     = [[xdg-open "%:p"]],
    errorformat = "",
    style_hint  = "html: reminder",
  }
end

return M
