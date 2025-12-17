local M = {}

function M.print_mapping()
  local enabled = vim.lsp._enabled_configs or {}
  local map = require("mason-lspconfig.mappings.server").lspconfig_to_package

  for lsp, _ in pairs(enabled) do
    local mason = map[lsp]
    if mason then
      print(string.format("%-30s -> %s", lsp, mason))
    else
      print(string.format("%-30s -> (no mason package)", lsp))
    end
  end
end

return M

