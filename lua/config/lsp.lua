-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
  },
  config = function()
    -- neodev: better Lua completion for Neovim config/plugins
    require("neodev").setup({})

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { disable = { "missing-fields" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
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

    -- Diagnostics: only show ERROR in virtual text/signs/underline
    vim.diagnostic.config({
      severity_sort = true,
      virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
      signs = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
      underline = {
        severity = { min = vim.diagnostic.severity.ERROR },
      },
    })

    -- Build ensure_installed list for Mason, but skip lua_ls
    local ensure = vim.tbl_keys(servers)
    for i, name in ipairs(ensure) do
      if name == "lua_ls" then
        table.remove(ensure, i)
        break
      end
    end

    require("mason").setup()

    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = ensure,
    })

    -- Capabilities (hook into cmp if present)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    local lspconfig = require("lspconfig")

    -- Newer mason-lspconfig has setup_handlers
    if mason_lspconfig.setup_handlers then
      mason_lspconfig.setup_handlers({
        function(server_name)
          local opts = servers[server_name] or {}
          opts.capabilities = capabilities
          lspconfig[server_name].setup(opts)
        end,
      })
    else
      -- Fallback for older versions: just loop our servers table
      for server_name, cfg in pairs(servers) do
        local opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, cfg)
        if lspconfig[server_name] then
          lspconfig[server_name].setup(opts)
        end
      end
    end
  end,
}

