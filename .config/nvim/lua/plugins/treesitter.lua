return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup({
      highlight = { 
        enable = true,
        disable = function(lang, buf)
          -- Only use treesitter for markdown popups
          if lang == "markdown" and vim.api.nvim_buf_get_name(buf) ~= "" then
            return true
          end

          return false
        end,
      },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    })
  end,
}
