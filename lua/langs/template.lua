-- lua/langs/template.lua
local M = {}

-- Notice: Snippets are handled by the lua/Snippets directory. These files are primarily for autocmds.
-- They allow for simple per language formatting.

-- files such as cpp.lua, nix.lua, py.lua point to this file.
-- do not just `cp template.lua haskell.lua` that's stupid, okay?

--- Generic language setup
--- @param opts table
---   opts.pattern     = FileType pattern (e.g. "cpp", "python")
---   opts.indent      = indent width (number, default 4)
---   opts.colorcolumn = string column ruler (default "80")
---   opts.makeprg     = optional :make program
---   opts.errorformat = optional errorformat
---   opts.style_hint  = optional style hint string
function M.setup_language(opts)
  local pattern     = opts.pattern
  local indent      = opts.indent or 4
  local colorcolumn = opts.colorcolumn or "80"
  local makeprg     = opts.makeprg
  local errorformat = opts.errorformat
  local style_hint  = opts.style_hint or (pattern .. ": remember to use snake_case.")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = pattern,
    callback = function(ev)
      -- Buffer/window handles
      local buf = ev.buf

      -- Indentation
      vim.bo[buf].expandtab   = true        -- use spaces, not tabs
      vim.bo[buf].shiftwidth  = indent      -- >> / << and auto-indent width
      vim.bo[buf].tabstop     = indent      -- how many spaces a <Tab> is
      vim.bo[buf].softtabstop = indent      -- how many spaces <BS> deletes
      vim.bo[buf].textwidth   = 0           --
      vim.wo.colorcolumn = colorcolumn      -- column ruler

      -- :make setup
      if makeprg then
        vim.bo[buf].makeprg = makeprg
      end
      if errorformat then
        vim.bo[buf].errorformat = errorformat
      end

      -- Style hint
      if style_hint then
        vim.schedule(function()
          vim.notify(style_hint, vim.log.levels.INFO, {
            title = "Style hint",
          })
        end)
      end
    end,
  })
end

return M
