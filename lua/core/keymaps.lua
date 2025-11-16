local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<c-o>", "<c-o>zz", opts)
map("n", "<c-d>", "<c-d>zz", opts)
map("n", "<c-u>", "<c-u>zz", opts)

map("n", "J", "mzJ`z", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

map("n", "Y", "y$")
map("n", "Q", "@q")

-- Remap arrow keys for visual line movement in normal and visual modes
map({'n', 'v'}, '<Down>', 'g<Down>', opts)
map({'n', 'v'}, '<Up>', 'g<Up>', opts)
map({'n', 'v'}, '<Left>', 'g<<Left>', opts)
map({'n', 'v'}, '<Right>', 'g<<Right>', opts)

map("x", "<leader>d", [["_d]], {desc="Delete to void register"})
map({"n", "v"}, "<leader>y", [["+y]], {desc="Yank selection to system clipboard"})
map("n", "<leader>Y", [["+Y]], {desc="Yank rest of line to system clipboard"})

-- Better window sizing
map("n", "<C-Left>",  ":vertical resize +2<CR>", opts)
map("n", "<C-Down>",  ":resize   +2<CR>", opts)
map("n", "<C-Up>",    ":resize   -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- saving binds
map('n', "<leader>w", ':w<CR>')
map('n', "<leader>q", ':q<CR>')
map('n', "<leader>so", ':source<CR>')

-- terminal binds
map('n', "<leader>t", (function()
  vim.cmd('vsplit')
  vim.cmd('term')
  vim.cmd('startinsert')
end))
map('t', '<Esc><Esc>', [[<C-\><C-n>:q<CR>]], opts)
