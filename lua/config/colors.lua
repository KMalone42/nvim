-- Sets colors to line numbers Above, Current and Below  in this order
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#50C878', bold=false })
vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=false })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#D2042D', bold=false })
