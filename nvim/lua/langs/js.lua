-- lua/langs/js.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "js",
    indent      = 2,
    colorcolumn = "100",
    makeprg     = "node %",
    errorformat = "",
    style_hint  = "js: prefer const/let, avoid var.",
  }
end

return M
