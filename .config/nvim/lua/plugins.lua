local M = {}

M.plugins = {}

function M.add_plugin(plugin)
  table.insert(M.plugins, plugin)
end

return M
