local function telescope_builtin(builtin, opts)
  return function()
    local themes = require("telescope.themes")
    local dropdown = themes.get_dropdown

    require("telescope.builtin")[builtin](dropdown(opts))
  end
end

local function find_files()
  local is_git_repo = vim.loop.fs_stat(vim.loop.cwd() .. "/.git")

  if is_git_repo then
    telescope_builtin("git_files", { show_untracked = true })()
  else
    telescope_builtin("find_files", { hidden = true })()
  end
end

local keys = {
  {
    "<leader><space>",
    -- function()
    --   local themes = require("telescope.themes")
    --   local dropdown = themes.get_dropdown
    --   require("telescope").extensions.frecency.frecency(dropdown({
    --     workspace = "CWD",
    --   }))
    -- end,
    find_files,
    desc = "Find files",
  },
  {
    "<leader>fr",
    telescope_builtin("oldfiles", { only_cwd = true }),
    desc = "Find recent",
  },
  {
    "<leader>/",
    telescope_builtin("live_grep"),
    desc = "Grep files",
  },
  {
    "<leader>:",
    telescope_builtin("command_history"),
    desc = "Find commands",
  },
  {
    "<leader>ff",
    telescope_builtin("current_buffer_fuzzy_find"),
    desc = "Find in buffer",
  },
}

local M = {}

function M.setup()
  require("plugins").add_plugin({
    "nvim-telescope/telescope.nvim",
    -- Dependent on treesitter to fix bug where highlighting is not applied if treesitter opens first file
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-frecency.nvim",
    },
    cmd = "Telescope",
    keys = keys,
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        -- defaults = {
        --   path_display = "tail",
        -- },
        extensions = {
          frecency = {
            show_scores = false,
            show_unindexed = true,
            hide_current_buffer = true,
            show_filter_column = false,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            disable_devicons = false,
            default_workspace = "CWD",
          },
        },
      })
    end,
  })

  require("plugins").add_plugin({
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  })
end

return M
