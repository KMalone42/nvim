local map = vim.keymap.set

map("n", "<leader>Go", "<cmd>Git<cr>", {desc="open Git menu"})
map("n", "<leader>ga", "<cmd>Git add .<cr>", {desc="adds current file to git"})
map("n", "<leader>gc", "<cmd>Git commit<cr>", {desc="open git commit menu"})
map("n", "<leader>gp", "<cmd>Git push<cr>", {desc="pushes to remote"})
map("n", "<leader>gr", "<cmd>GRemove<cr>", {desc="removes from git and clears buffer"})
map("n", "<leader>gv", "<cmd>Fugit2<cr>", {desc="view current git tree (Fugit2)"})
map("n", "<leader>gd", "<cmd>Fugit2Diff<cr>", {desc="[g]it [d]iff viewer (Fugit2)"})
map("n", "<leader>gg", "<cmd>Fugit2Graph<cr>", {desc="[g]it [g]raph viewer (Fugit2)"})
