-- lua/config/lsp.lua
-- Nvim 0.11+ LSP setup using vim.lsp.config + vim.lsp.enable

-- Global on_attach (keymaps etc.)
local function on_attach(client, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K",  vim.lsp.buf.hover)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
end

-- Capabilities (optional: integrate nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end)

-- 1) Global defaults for *all* LSP configs
vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- 2) Per-server tweaks (only where you need them)

-- Lua / Neovim config
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- (Everything else can use nvim-lspconfig's built-in defaults)

-- 3) Enable servers so they auto-start on matching filetypes/root
vim.lsp.enable({
  "pyright",
  "lua_ls",
  "bashls",
  "vimls",
  "ts_ls",                  -- was tsserver
  "systemd_ls",             -- NOTE: _ls suffix
  "dockerls",
  "awk_ls",
  "jdtls",
  "kotlin_language_server",
})

