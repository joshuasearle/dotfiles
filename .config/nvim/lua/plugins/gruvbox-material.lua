return {
  "sainnhe/gruvbox-material",
  config = function()
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_diagnostic_virtual_text = "colored"

    -- would like option to hightlight virtual text, but not supported yet
    -- https://github.com/sainnhe/gruvbox-material/issues/167

    vim.cmd.colorscheme("gruvbox-material")
  end,
}
