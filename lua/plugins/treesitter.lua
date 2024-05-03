return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local tree_sitter_configs = require("nvim-treesitter.configs")
    tree_sitter_configs.setup({
      -- ensure_installed = { "lua", "javascript", "python" },
      auto_install = true,
      sync_install = true,
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
