local format = function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b.autoformat == false then
    return
  end
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    vim.lsp.buf.format({
      range = {
        ["start"] = { start_row, 0 },
        ["end"] = { end_row, 0 },
      },
      async = true,
    })
    return
  end

  local tbl = vim.tbl_deep_extend("force", {
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  }, require("lazyvim.util").opts("nvim-lspconfig").format or {})

  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    tbl = tbl.tbl_deep_extend("force", {
      range = {
        ["start"] = { start_row, 0 },
        ["end"] = { end_row, 0 },
      },
    })
  end

  print("formatting")
  vim.lsp.buf.format(tbl)
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "smjonas/inc-rename.nvim",
    "jose-elias-alvarez/typescript.nvim",
    "glepnir/lspsaga.nvim",
  },
  opts = {
    autoformat = false,
    -- make sure mason installs the server
    servers = {
      ---@type lspconfig.options.tsserver
      tsserver = {
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
      },
    },
    setup = {
      tsserver = function(_, opts)
        require("lazyvim.util").on_attach(function(client, buffer)
          if client.name == "tsserver" then
            -- stylua: ignore
            vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
            -- stylua: ignore
            vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
          end
        end)
        require("typescript").setup({ server = opts })
        return true
      end,
    },
  },
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()

    local keymaps = {
      { "gf", "<cmd>Lspsaga lsp_finder<CR>", desc = "LSP finder" },
      { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
      { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
      { "gD", "<cmd>Lspsaga goto_definition<CR>", desc = "Goto definition" },
      { "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics" },
      { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
      { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" },
      {
        "]E",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Next error",
      },
      {
        "[E",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = "Previous error",
      },
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover" },
      { "gr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
      { "gI", "<cmd>Telescope lsp_implementations<CR>", desc = "Implementations" },
      { "<leader>cf", format, desc = "Format document" },
      {
        "<leader>cf",
        format,
        mode = "v",
        has = "documentRangeFormatting",
        desc = "Format range",
      },
    }

    for _, key in pairs(keymaps) do
      keys[#keys + 1] = key
    end
  end,
}
