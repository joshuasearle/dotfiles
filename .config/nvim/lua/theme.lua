local M = {}

function M.setup()
  local opt = vim.opt

  -- Use dark background
  opt.background = "dark"

  -- Enable 24 bit colors
  opt.termguicolors = true

  -- TODO: Find better place for these settings
  -- Show sign column
  opt.signcolumn = "yes"

  -- Add line numbers
  opt.number = true
  opt.relativenumber = true

  -- Disable cursor styling
  opt.guicursor = ""

  -- Highlight current line
  opt.cursorline = true

  -- Only display command line when typing
  -- Currently opt.cmdheight create press enter messages w/ telescope
  opt.cmdheight = 1

  -- Create colorcolumn
  opt.colorcolumn = "80"
  -- TODO END

  require("plugins").add_plugin({
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"

      vim.cmd.colorscheme("gruvbox-material")
    end,
  })
end

return M
