return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        styles = {
          comments = { 'italic' }, -- Change the style of comments
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          miscs = {}, -- Uncomment to turn off hard-coded styles
        },
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
}
