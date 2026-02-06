-- lua/config/lsp.lua
-- Nvim 0.11+ LSP setup using vim.lsp.config + vim.lsp.enable

-- Global on_attach (keymaps etc.)
local function on_attach(client, bufnr)
  local map = vim.keymap.set
  local opts = { buffer = 0, silent = true }

  map("n", "gd", vim.lsp.buf.definition,     vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  map("n", "gD", vim.lsp.buf.declaration,    vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation (inheritance)" }))
  map("n", "gt", vim.lsp.buf.type_definition,vim.tbl_extend("force", opts, { desc = "Go to type" }))
  map("n", "gr", vim.lsp.buf.references,     vim.tbl_extend("force", opts, { desc = "List references" }))

  map("n", "K",  vim.lsp.buf.hover)
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
-- I don't think this is actually doing anything in particular.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("ts_ls", {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, {
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      "deno.json",
      "deno.jsonc",
      ".git",
    })
    on_dir(root or vim.fn.getcwd())
  end,
})



-- Enable servers so they auto-start on matching filetypes/root
-- :h lspconfig-all
vim.lsp.enable({
  "pyright",
  "lua_ls",
  "systemd_ls",
  "bashls",
  "vimls",
  "ts_ls",
  "dockerls",
  "awk_ls",
  "jdtls",
  "kotlin_language_server",
  "rust_analyzer",
  "eslint",
  "tailwindcss",
  "nixd",
--"ccls",
  "clangd",
  "perlnavigator",
  "sqlls",
})

