-- lua/plugins/mason.lua

-- mason-lspconfig is a package that allows me to declare lsps in config/lsp.lua
-- lsp.lua names come from `:h lspconfig-all`
-- this takes those names and downloads corresponding mason packages
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = { "lua_ls", "basedpyright", "rust_analyzer" },
  },
}
