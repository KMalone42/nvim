-- lua/langs/cpp.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "cpp",
    indent      = 4,
    colorcolumn = "80",
    makeprg     = "g++ -std=c++20 -Wall -Wextra % -o %:r.out",
    errorformat = [[%f:%l:%c: %t%*[^:]: %m]],
    style_hint  = "C++: use camelCase, RAII, and prefer modern C++20 features.",
  }
end

return M
