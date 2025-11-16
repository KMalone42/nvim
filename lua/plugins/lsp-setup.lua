require('mason').setup()
require('mason-lspconfig').setup()

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
    --perl-debug-adapter = {},
    perlnavigator = {},
    codebook = {},
}

vim.lsp.enable('glsl_analyzer')

require('neodev').setup()

require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
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

