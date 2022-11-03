-- nordfox, palefox, dayfox, dawnfox and duskfox, nightfox.
-- require('nightfox').load("nightfox")
--
--
---- Example config in Lua
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
-- Tokyo night
-- vim.g.tokyonight_style  = "night"
require("tokyonight").setup({

  style = 'storm',
  transparent = true,
  styles = {
    comments = 'NONE',
    functions = 'NONE',
    keywords = 'NONE',
    strings = 'NONE',
    variables = 'NONE',
    sidebars = 'transparent',
    floats = 'transparent'
  },
  on_highlights = function(hl, c)
    hl.LspDiagnosticsDefaultHint = { fg = c.blue }
    hl.LspDiagnosticsDefaultInformation = { fg = c.blue }
    hl.LspDiagnosticsDefaultWarning = { fg = c.yellow }
    hl.LspDiagnosticsDefaultError = { fg = c.red }
    -- remove telescope background
    hl.TelescopeNormal = { bg = 'NONE' }
    hl.TelescopeBorder = { bg = 'NONE' }
    hl.TelescopePromptBorder = { bg = 'NONE' }
    hl.TelescopeResultsBorder = { bg = 'NONE' }
    hl.TelescopePreviewBorder = { bg = 'NONE' }
  end,

})
vim.g.tokyonight_italic_functions = true
vim.cmd [[colorscheme tokyonight]]
-- vim.cmd[[colorscheme tokyonight-night]]
-- change highlight color for indent blankline
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#1a1b26 gui=NONE]]
-- change highlight colors for telescope
vim.cmd [[highlight TelescopePromptBorder guifg=#2d2e43 gui=NONE]]
vim.cmd [[highlight TelescopePreviewBorder guifg=#2d2e43 gui=NONE]]
vim.cmd [[highlight TelescopeResultsBorder guifg=#2d2e43 gui=NONE]]
-- change highlight for float window background
vim.cmd [[highlight NormalFloat guibg=NONE]]
