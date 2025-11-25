-- lua/langs/nix.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "nix",
    indent      = 2,
    colorcolumn = "100",
    makeprg     = "nix eval --file %",
    errorformat = [[%Eerror: %m at %f:%l:%c,%Z%.%#]],
    style_hint  = "nix: remember to use camelCase.",
  }
end

return M
