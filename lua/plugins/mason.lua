-- lua/plugins/mason.lua
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
          "lua_ls",
          "basedpyright",
          "ruff",
          "bashls",
          "ansiblels",
          "cssls",
          "awk_ls",
          "systemd_ls",
          "perlnavigator",
          "glsl_analyzer",
    },
    automatic_installation = false,
  },
}
