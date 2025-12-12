-- lua/langs/css.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "css",
    indent      = 2,
    colorcolumn = "100",
    makeprg     = "",
    errorformat = "",
    style_hint  = "css: avoid !important, prefer flex/grid.",
  }
end

return M

