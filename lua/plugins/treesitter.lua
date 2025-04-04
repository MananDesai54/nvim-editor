return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local tree_sitter_configs = require("nvim-treesitter.configs")
    tree_sitter_configs.setup({
      -- ensure_installed = { "lua", "javascript", "python" },
      auto_install = true,
      sync_install = true,
      highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { 
        enable = true 
      },
      -- Code folding
      fold = {
        enable = true,
        disable = { "markdown" },
      },
      -- Text objects
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })

    -- Set up folding
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false -- Don't fold by default
    vim.opt.foldlevel = 99 -- Don't fold by default
    vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

    -- Key mappings for folding
    vim.keymap.set("n", "zc", "zc", { desc = "Fold current block" })
    vim.keymap.set("n", "zo", "zo", { desc = "Unfold current block" })
    vim.keymap.set("n", "zC", "zC", { desc = "Fold all blocks" })
    vim.keymap.set("n", "zO", "zO", { desc = "Unfold all blocks" })
    vim.keymap.set("n", "za", "za", { desc = "Toggle fold" })
    vim.keymap.set("n", "zA", "zA", { desc = "Toggle fold recursively" })
    vim.keymap.set("n", "zR", "zR", { desc = "Unfold all" })
    vim.keymap.set("n", "zM", "zM", { desc = "Fold all" })
  end
}
