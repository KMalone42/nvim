-- init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = ' '

require("config.lazy")
require("config.colors")
require("langs").setup()
require("plugin-keymaps")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.mouse = 'a' -- enable mouse 'all'

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

-- Additional opts
vim.opt.scrolloff = 999 -- always center the cursor
vim.opt.undofile = true -- persistent undo history
vim.wo.number = true -- enable absolute line numbers
vim.wo.signcolumn = 'yes' -- always show sign column (LSP errors, Git gutter)
vim.opt.completeopt = 'menuone,noselect' -- completion popup behavior
vim.opt.termguicolors = true -- enable full 24-bit RGB color
vim.opt.colorcolumn = "79" -- Default column ruler (may already be handled by langs)

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false -- disable highlight after search

-- wrap behavior (only if wrap=true)
vim.opt.linebreak = true -- wrap only at 'nice' boundaries (spaces, punctuation)
vim.opt.breakindent = true -- wrapped lines maintain indentation

-- Update time
vim.opt.updatetime = 250 -- triggering for CursorHold, autocommands, LSP diagnostics
vim.opt.timeoutlen = 300 -- keymaps such as gq, z= wait for more keys

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Removing this logic for nix
-- set default windows shell to powershell
--if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    --opt.shell = 'powershell.exe'
--else
    ---- on linux will default to /bin/bash now
    --opt.shell = '/bin/bash'
--end
