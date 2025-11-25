-- lua/langs/lua_lang.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "lua",
    indent      = 2,
    colorcolumn = "100",
    makeprg     = "luac -p %",
    errorformat = "%E%f:%l: %m",
    style_hint  = "lua: remember to use camelCase.",
  }
end

return M
