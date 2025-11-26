-- lua/langs/rs.lua
local template = require("langs.template")

local M = {}

function M.setup()
  template.setup_language{
    pattern     = "rs",
    indent      = 4,
    colorcolumn = "80",
    makeprg     = "cargo run",
    errorformat = [[%Eerror:%m,%Wwarning:%m,%f:%l:%c: %m]],
    style_hint  = "Rust: prefer ownership and borrowing over cloning; use idiomatic naming (snake_case), Result<> for errors, and cargo fmt + clippy.",
  }
end

return M
