local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "diff",
    "dockerfile",
    "gitcommit",
    "gitignore",
    "go",
    "help",
    "html",
    "javascript",
    "json",
    "latex",
    "lua",
    "make",
    "markdown",
    "python",
    "regex",
    "rust",
    "toml",
    "vim",
    "yaml",
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    -- python
    "pyright",
    "python-lsp-server",
    "mypy",
    "black",
    "isort",
    -- rust
    "rustfmt",
    "rust-analyzer",
    -- misc
    "prettier",
    "ltex-ls",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.cmp = {
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
  },
    },
    { name = "nvim_lua" },
    { name = "path" },
    {
      name = 'tmux',
      option = {
        all_panes = true,
        label = '[tmux]',
        trigger_characters = { '.' },
        trigger_characters_ft = {}, -- { filetype = { '.' } }
      },
    },
  },
}

return M
