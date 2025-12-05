local theme = {}



    theme.colors =  {
  bg     = "none"   ,
  white  = "#ffffff",
  red    = "#e50000",
  pink   = "#ef5e90",
  dark   = "#2c1d16",
  green  = "#86a83e",
  yellow = "#e5e500",
  blue   = "#89b4fa",
  blue2  = "#163556",
  green2 = "#14fa4e",
  cyan   = "#1cd4ee",
  orange = "#ef5734",
                    }

            theme.setup = function()

  vim.api.nvim_set_hl(
                     0,
                     "Normal",
                     { fg = theme.colors.cyan, bg = theme.colors.bg }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "Comment",
                     { fg = theme.colors.green2, italic = true }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "Constant",
                     { fg = theme.colors.orange }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "String",
                     { fg = theme.colors.green }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "Function",
                     { fg = theme.colors.pink, bold = true }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "Keyword",
                     { fg = theme.colors.pink, bold = true }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "@operator",
                     { fg = theme.colors.orange }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "Delimiter",
                     { fg = theme.colors.yellow }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "Special",
                     { fg = theme.colors.yellow }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "@variable",
                     { fg = theme.colors.cyan }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "LineNr",
                     { fg = theme.colors.dark, bg = "none" }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "CursorLineNr",
                     { fg = "#ffffff", bold = true }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "StatusLine",
                     { fg = "#ffffff", bg = theme.colors.pink, bold = true }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "StatusLineNC",
                     { fg = theme.colors.dark, bg = theme.colors.yellow }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "Visual",
                     { fg = theme.colors.green2, bg = theme.colors.dark }
                     )
              -- telescope --
  vim.api.nvim_set_hl(
                     0,
                     "TelescopeBorder",
                     { fg = theme.colors.pink, bg = theme.colors.bg }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "TelescopeSelection",
                     { fg = theme.colors.yellow, bg = theme.colors.bg }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "TelescopePromptPrefix",
                     { fg = theme.colors.pink, bg = theme.colors.bg }
                     )
                -- blink --
  vim.api.nvim_set_hl(
                     0,
                     "Pmenu",
                     { fg = theme.colors.blue, bg = theme.colors.bg }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "WhichKeyNormal",
                     { fg = theme.colors.blue2, bg = theme.colors.bg }
                     )
  vim.api.nvim_set_hl(
                     0,
                     "TreesitterContext",
                     { fg = theme.colors.blue2, bg = theme.colors.dark }
                     )
                    end

return theme


