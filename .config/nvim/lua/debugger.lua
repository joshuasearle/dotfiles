local M = {}

M.adapters = {}

function M.add_adapter(name, opts)
  table.insert(M.adapters, { name = name, opts = opts })
end

M.configurations = {}

function M.add_configuration(lang, opts)
  table.insert(M.configurations, { name = lang, opts = opts })
end

function M.setup()
  local plugins = require("plugins")

  plugins.add_plugin({
    "mfussenegger/nvim-dap",
    lazy = false,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>bt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        -- Debug next
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
        desc = "Step over (next line)",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>ds",
        function()
          require("dap").close()
        end,
        desc = "Close debug session",
      },
    },
    config = function()
      local dap = require("dap")

      for _, adapter in ipairs(M.adapters) do
        dap.adapters[adapter.name] = adapter.opts
      end

      for _, configuration in ipairs(M.configurations) do
        dap.configurations[configuration.name] = dap.configurations[configuration.name] or {}
        table.insert(dap.configurations[configuration.name], configuration.opts)
      end
    end,
  })

  local adapter_names = {}

  for _, adapter in ipairs(M.adapters) do
    table.insert(adapter_names, adapter.name)
  end

  plugins.add_plugin({
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = adapter_names,
      automatic_installation = true,
    },
  })

  plugins.add_plugin({
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "breakpoints",
              size = 0.5,
            },
            {
              id = "stacks",
              size = 0.5,
            },
          },
          position = "right",
          size = 40,
        },
        {
          elements = {
            {
              id = "scopes",
              size = 1,
            },
          },
          position = "bottom",
          size = 15,
        },
      },
    },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
    },
  })
end

return M
