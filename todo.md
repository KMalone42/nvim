# Rust imports
---



There are basically **two “IDE magic” paths** for Rust:

1. **rust-analyzer via your editor (Neovim, VS Code, etc.)**
2. **`cargo fix` from the CLI**

I’ll lean Neovim-first since that’s what you’re using, then mention VS Code quickly.

---

## 1. Neovim + rust-analyzer: organize + delete imports

Assuming you already have `rust-analyzer` wired up with `vim.lsp` (which you do, from your other messages):

### a) Use LSP code actions: “organize imports”

You can call this manually:

```vim
:lua vim.lsp.buf.code_action({ only = { "source.organizeImports" } })
```

What this does:

* Asks rust-analyzer for a “source.organizeImports” action.
* rust-analyzer returns “here’s how to reorder and prune imports”.
* Neovim applies the edit.

You can bind that to a key in your LSP `on_attach`:

```lua
-- somewhere in your LSP setup
vim.keymap.set("n", "<leader>oi", function()
  vim.lsp.buf.code_action({ only = { "source.organizeImports" } })
end, { desc = "Organize imports" })
```

Workflow:

1. Edit file.
2. Hit `<leader>oi`.
3. Imports get sorted / deduped / trimmed (depending on rust-analyzer config).

---

### b) Use quick-fix actions for specific imports

Whenever you see an “unused import” underline:

* Put cursor on the import line.
* Run your normal LSP code-action mapping (often `<leader>ca` or `ga`).
* Choose “Remove this import”.

That’s more granular, but nice when you don’t want to touch the whole list.

---

### c) Combine with format-on-save (optional)

You can make “organize imports” happen every save by triggering the code action on `BufWritePre`.

Rough sketch:

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.code_action({
      only = { "source.organizeImports" },
      apply = true,
    })
  end,
})
```

Now saving a Rust file will auto-tidy imports.

> Note: if you already have a `BufWritePre` doing `vim.lsp.buf.format()`, you might want to combine the two to avoid double-calls.

---

## 2. `cargo fix`: CLI magic to remove unused imports

Rust has a built-in fixer that applies compiler suggestions, including removing unused imports.

From your project root:

```bash
cargo fix
```

Useful flags:

```bash
# allow edits even if the repo is dirty
cargo fix --allow-dirty

# only touch a specific binary target, if you have several
cargo fix --bin my-tui

# or library only
cargo fix --lib
```

What it does:

* Runs `cargo check`.
* For each “unused import” / “dead code” with an auto-fix, it rewrites your `.rs` files.
* Imports that are never used just vanish.

I like this for “I just refactored everything and now 20 imports are screaming at me” moments.

---

## 3. If you ever hop into VS Code

Just so you know the equivalent:

In `settings.json`:

```json
{
  "editor.codeActionsOnSave": {
    "source.organizeImports": true
  },
  "[rust]": {
    "editor.defaultFormatter": "rust-lang.rust-analyzer"
  }
}
```

Then every save:

* rust-analyzer formats,
* and runs “organize imports”.

---

### TL;DR for you specifically

If you want one-button magic in Neovim:

1. Add this mapping:

```lua
vim.keymap.set("n", "<leader>oi", function()
  vim.lsp.buf.code_action({ only = { "source.organizeImports" } })
end, { desc = "Organize imports" })
```

2. When a file feels import-gross, hit `<leader>oi`.

And for big refactors, occasionally run:

```bash
cargo fix --allow-dirty
```

That combo gets you 95% of the way to “I never think about imports unless I want to.”

