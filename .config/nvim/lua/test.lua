local M = {}

M.adapters = {}

function M.add_adapter(name, config)
  table.insert(M.adapters, {
    name = name,
    config = config,
  })
end

function M.setup()
  local dependencies = {
    "nvim-neotest/neotest",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  }

  for _, adapter_config in ipairs(M.adapters) do
    table.insert(dependencies, adapter_config.name)
  end

  require("plugins").add_plugin({
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    config = function()
      local adapters = {}
      for _, adapter_config in ipairs(M.adapters) do
        local require_name = adapter_config.name:match("([^/]+)$")
        table.insert(adapters, require(require_name)(adapter_config.config))
      end
      require("neotest").setup({
        adapters = adapters,
      })
    end,
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run file tests",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open()
        end,
        desc = "Open test output",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.open()
        end,
        desc = "Open test summary",
      },
    },
  })
end

return M
