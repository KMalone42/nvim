-- init.lua
require("plugins")
require("langs").setup()
require("core.options")
require("core.keymaps")
require("core.colors")
require("plugins")
require("plugin-keymaps")
require("file-types")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
