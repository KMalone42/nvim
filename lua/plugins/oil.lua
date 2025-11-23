-- lua/plugins/oil.lua
return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = {
    view_options = {
        show_hidden = true,
        case_insensitive = true,
    }
  }
}
