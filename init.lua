vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("core.options")
require("core.keymaps")
require("core.colors")

require("plugins")

require("plugin-keymaps")

require("file-types")

-- Run current Python file with :make
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.makeprg = "python3 %"
    -- Parse lines like:   File "script.py", line 12, in <module>
    vim.opt_local.errorformat =
      [[%E  File "%f", line %l,%C%p^,%Z%m,%-G%.%#]]
  end,
})

-- After :make, open quickfix if there are errors
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "make",
  command = "cwindow"
})

-- custom digraphs
-- Precomposed forms where they exist; fallback to combining U+0304.
local macron_precomposed = {
  a = "ā", e = "ē", i = "ī", o = "ō", u = "ū", y = "ȳ",
  A = "Ā", E = "Ē", I = "Ī", O = "Ō", U = "Ū", Y = "Ȳ",
}

function _G.MacronizeNextKey()
  local k = vim.fn.getcharstr()  -- next typed key as a UTF-8 string
  -- If it’s one of the common vowels (or Y), use precomposed.
  local pre = macron_precomposed[k]
  if pre then
    return pre
  end
  return k .. "\u{0304}"
end

-- insert x with macron (or x bar) with <C-g>-, x
vim.keymap.set("i", "<C-g>-", "v:lua.MacronizeNextKey()", {
  expr = true,
  desc = "Insert next key with macron",
})

vim.o.timeout = true
vim.o.timeoutlen = 1500
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50
