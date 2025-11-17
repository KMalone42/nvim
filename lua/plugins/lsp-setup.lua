require('neodev').setup() -- not sure what this is really

-- how to edit: 
-- add lsp server name (NOT ANSIBLE PACKAGE)
-- :help mason.nvim
-- :lua print(vim.inspect(require("mason-lspconfig.mappings.server").package_to_lspconfig))
-- not working
-- :lua print(vim.inspect(require("mason-lspconfig.mappings.server").ansible-language-server))

local servers = {
    lua_ls = {
        Lua = {
            diagnostics = { disable = {'missing-fields'} },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    basedpyright = {},
    ruff = {},
    bashls = {},
    ast_grep = {},
    ansiblels = {},
    cssls = {},
    awk_ls = {},
    systemd_ls = {},
    perlnavigator = {},
    codebook = {},
    glsl_analyzer = {},
}

-- vim.diagnostics.config({virtual_text=false})
-- keep errors but hide warnings
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  signs = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
})

-- use servers for settings, but build a separate list for Mason:
local ensure = vim.tbl_keys(servers)
for i, name in ipairs(ensure) do
  if name == "lua_ls" then
    table.remove(ensure, i)
    break
  end
end

require('mason').setup()
require('mason-lspconfig').setup {
    ensure_installed = ensure,
}
