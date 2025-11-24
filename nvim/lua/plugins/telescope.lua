-- lua/plugins/telescope.lua

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({})

    -- Safe extensions loading (doesn't error if missing)
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "undo")
  end,
}

