-- lua/langs/init.lua
local M = {}

-- All language modules to load
local language_modules = {
    "langs.cpp",
    "langs.lua_lang",
    "langs.nix",
    "langs.py",
}

function M.setup()
  for _, modname in ipairs(language_modules) do
    local ok, mod = pcall(require, modname)
    if ok and type(mod.setup) == "function" then
      mod.setup()
    else
      vim.notify("langs: failed to load " .. modname, vim.log.levels.WARN)
    end
  end
end

return M
