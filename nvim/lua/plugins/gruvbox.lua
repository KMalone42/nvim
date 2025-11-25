-- lua/plugins/gruvbox.lua

return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,  -- load before any UI plugins
  opts = {
    transparent_mode = true,
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd("colorscheme gruvbox")
  end,
}

