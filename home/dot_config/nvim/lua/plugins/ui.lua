return {

  -- floating winbar
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    enabled = false,
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
            InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- ident blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")
      -- vim.g.indent_blankline_use_treesitter = true
      -- vim.g.indent_blankline_show_first_ident_level = false

      require("indent_blankline").setup {
        -- char = "|",
        -- use_treesitter = true,
        -- show_trailing_blankline_indent = true,
        show_first_indent_level = false,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

}
