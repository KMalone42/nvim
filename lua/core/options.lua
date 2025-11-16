local opt = vim.o
-- Sets cursor to always be in the center
opt.scrolloff = 999

-- Set highlight on search
opt.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Relative line numbers
opt.relativenumber = true

-- Enable mouse mode
opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
opt.clipboard = 'unnamedplus'

-- Indenting setting
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true

-- Enable wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

opt.completeopt = 'menuone,noselect'

opt.termguicolors = true

-- Set a colored line at 80 chars
opt.colorcolumn = "79"

opt.splitbelow = true
opt.splitright = true

opt.undofile = true

-- set default windows shell to powershell
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    opt.shell = 'powershell.exe'
else
    -- on linux will default to /bin/bash now
    opt.shell = '/bin/bash'
end
