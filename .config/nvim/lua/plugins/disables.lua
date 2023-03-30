local plugins_to_disable = {
  "lukas-reineke/indent-blankline.nvim",
  "echasnovski/mini.indentscope",
  "goolord/alpha-nvim",
  "echasnovski/mini.starter",
}

local plugin_options = {}

for _, plugin_name in pairs(plugins_to_disable) do
  table.insert(plugin_options, { plugin_name, enabled = false })
end

return plugin_options
