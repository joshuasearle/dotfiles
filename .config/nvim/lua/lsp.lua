local M = {}

M.langs = {}

function M.add_lsp(lang, settings)
  local config = {
    settings = settings,
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  }

  table.insert(M.langs, { name = lang, config = config })
end

function M.setup()
  local plugins = require("plugins")

  plugins.add_plugin({
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "glepnir/lspsaga.nvim",
    },
    config = function()
      require("mason").setup()

      local ensure_installed = {}

      for _, lang in ipairs(M.langs) do
        table.insert(ensure_installed, lang.name)
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed
      })

      local lspconfig = require("lspconfig")

      for _, lang in ipairs(M.langs) do
        lspconfig[lang.name].setup(lang.config)
      end
    end,
  })

  plugins.add_plugin({
    "glepnir/lspsaga.nvim",
    opts = {
      scroll_preview = {
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
    },
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
    },
    keys = {
      {
        "<leader>ca",
        "<cmd>Lspsaga code_action<CR>",
        desc = "Code action",
      },
      {
        "<leader>cr",
        "<cmd>Lspsaga rename<CR>",
        desc = "Rename",
      },
      {
        "K",
        "<cmd>Lspsaga hover_doc<CR>",
        desc = "Hover",
      },
      {
        "gd",
        function()
          vim.lsp.buf.definition()
        end,
        desc = "Goto definition",
      },
      {
        "[e",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Previous error",
      },
      {
        "]e",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Next error",
      },
      {
        "[w",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARNING })
        end,
        desc = "Previous warning",
      },
      {
        "]w",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARNING })
        end,
        desc = "Next warning",
      },
      {
        "gf",
        "<cmd>Lspsaga finder<CR>",
        desc = "LSP finder"
      },
      {
        "<leader>cd",
        "<cmd>Lspsaga show_line_diagnostics<CR>",
        desc = "Show line diagnostics"
      },
      {
        "gr",
        "<cmd>Telescope lsp_references<CR>",
        desc = "References"
      },
      {
        "gI",
        "<cmd>Telescope lsp_implementations<CR>",
        desc = "Implementations"
      },
      {
        "<leader>cf",
        function()
          vim.lsp.buf.format()
        end,
        mode = "v",
      }
    },
  })
end

return M
