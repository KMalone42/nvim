-- goto lsp keymaps
vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, {desc='[G]oto [D]efinition'})
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {desc='[G]oto [R]eferences'})
vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, {desc='[G]oto [I]mplementation'})
vim.keymap.set('n', '<leader>ls', require('telescope.builtin').lsp_document_symbols, {desc='[L]ist [S]ymbols'})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc='[G]oto [D]eclaration'})

-- documentation lsp keymaps
vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, {desc='Type [D]efinition'})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc='Symbol Documentation'})
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {desc='Signature Documentation'})

-- refactor lsp keymaps
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {desc='[R]e[n]ame'})
vim.keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
end, {desc='[C]ode [Action]'})

-- jump to next error or warning
do
    local jumpToError = function (jumpCount)
        vim.diagnostic.jump({count = jumpCount, float = true})
    end
    vim.keymap.set('n', "<leader>n", function() jumpToError(1)  end, {desc="Jump to next diagnostic"})
    vim.keymap.set('n', "<leader>N", function() jumpToError(-1) end, {desc="Jump to previous diagnostic"})
end
