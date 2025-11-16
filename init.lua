vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("core.options")
require("core.keymaps")
require("core.colors")

require("plugins")

require("plugin-keymaps")

require("file-types")

-- Nix autocmd
vim.api.nvim_create_autocmd("FileType", {
    pattern = "nix",
    callback = function()
	    vim.opt_local.shiftwidth = 2
	    vim.opt_local.tabstop = 2
	end, 
})

-- Python autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- :make it work
    vim.opt_local.makeprg = "python3 %"
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
function _G.MacronizeNextKey()
  local k = vim.fn.getcharstr()  -- next typed key as a UTF-8 string
  return k .. "\u{0304}"
end

local superscript_precomposed = {
  -- numbers
  ["0"] = "⁰", ["1"] = "¹", ["2"] = "²", ["3"] = "³", ["4"] = "⁴", ["5"] = "⁵",
  ["6"] = "⁶", ["7"] = "⁷", ["8"] = "⁸", ["9"] = "⁹",
  -- operators
  ["+"] = "⁺", ["-"] = "⁻",

  -- letters
  ["n"] = "ⁿ", ["a"] = "ᵃ", ["x"] = "ˣ", ["y"] = "ʸ", ["z"] = "ᶻ",
}
function _G.ExponentNextNum()
  local k = vim.fn.getcharstr()
  local pre = superscript_precomposed[k]
  if pre then
    return pre
  end
end

-- insert x with macron (or x bar) with <C-g>-, x
vim.keymap.set("i", "<C-g>-", "v:lua.MacronizeNextKey()", {
  expr = true,
  desc = "Insert next key with macron",
})
-- insert 1 as exponent with <C-g>^, 1
vim.keymap.set("i", "<C-g>^", "v:lua.ExponentNextNum()", {
  expr = true,
  desc = "Insert next key as exponent",
})

vim.o.timeout = true
vim.o.timeoutlen = 1500
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50


-- Load per-ft Lua snippets from your folder
require("luasnip.loaders.from_lua").lazy_load({
  paths = vim.fn.expand("~/.config/nvim/lua/snippets"),
})
