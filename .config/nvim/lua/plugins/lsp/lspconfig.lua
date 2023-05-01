local M = {}

local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local format = function()
  print("!!!#!#!#!#!#!#!#!!#")
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
  }, {})

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

  vim.lsp.buf.format(tbl)
end

local keys = {
  { "gf", "<cmd>Lspsaga lsp_finder<CR>", desc = "LSP finder" },
  { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
  { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
  { "gD", "<cmd>Lspsaga goto_definition<CR>", desc = "Goto definition" },
  { "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics" },
  { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
  { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic" },
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
  { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  { "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
  { "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },
  { "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
  { "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
  { "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
  { "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
}

M.on_attach = function()
  for _, value in ipairs(keys) do
    local key, cmd, desc, mode = value[1], value[2], value.desc, value.mode
    vim.keymap.set(mode or "n", key, cmd, { silent = true, noremap = true, desc = desc })
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.csharp_ls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.bashls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.pyright.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

lspconfig.tsserver.setup({
  on_attach = function()
    require("typescript").setup({})
    M.on_attach()
    vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { desc = "Organize Imports" })
    vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File" })
  end,
  capabilities = M.capabilities,
})

return M

