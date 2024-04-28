local langs = {
  "bash",
  "go",
  "lua",
  "markdown",
  "python",
  "yaml",
}

for _, lang in ipairs(langs) do
  local lang_config = require("langs." .. lang)
  local pattern = lang_config.pattern or lang

  lang_config.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = pattern,
    callback = function()
      lang_config.on_attach()
    end,
  })
end

local features = {
  "ai",
  "autosave",
  "bindings",
  "center",
  "comment",
  "complete",
  "debugger",
  "explorer",
  "formatting",
  "fzf",
  "git",
  "globals",
  "highlight",
  "indent",
  "lsp",
  "kitty",
  "other",
  "pairs",
  "practice",
  "scroll",
  "search",
  "snippets",
  "split",
  "statusline",
  "tabs",
  "test",
  "theme",
  "undo",
}

for _, feature in ipairs(features) do
  require(feature).setup()
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins").plugins

require("lazy").setup(plugins)
