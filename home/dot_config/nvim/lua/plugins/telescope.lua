return {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-fzf-native.nvim",
  dependencies = {
    {
      "nvim-lua/plenary.nvim"
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require('telescope').load_extension('fzf')
      end
    }
  },
  opts = {
    defaults = {
      preview = false
    }
  }
}
