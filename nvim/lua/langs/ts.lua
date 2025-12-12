-- lua/langs/ts.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "typescript",
    indent      = 2,
    colorcolumn = "100",
    makeprg     = "ts-node %",
    errorformat = "",
    style_hint  = "ts: type everything explicitly when possible.",
  }
end

return M

