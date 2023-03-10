local overrides = require "custom.plugins.overrides"

---@type {[PluginName]: NvPluginConfig|false}
local plugins = {

  -- ["goolord/alpha-nvim"] = { disable = false } -- enables dashboard

  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["andersevenrud/cmp-tmux"] = { after = "nvim-cmp" },
  ["williamboman/mason.nvim"] = { override_options = overrides.mason },
  ["nvim-tree/nvim-tree.lua"] = { override_options = overrides.nvimtree },
  ["hrsh7th/nvim-cmp"] = { override_options = overrides.cmp },
  ["nvim-treesitter/nvim-treesitter"] = { override_options = overrides.treesitter },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["easymotion/vim-easymotion"] = {
    vim.cmd([[
      let g:EasyMotion_do_mapping = 0 " Disable default mappings
      let g:EasyMotion_smartcase = 1
      nmap s <Plug>(easymotion-overwin-f)
    ]])
  },
  ["tpope/vim-repeat"] = {},
  ["tpope/vim-surround"] = {},
  ["tpope/vim-unimpaired"] = {},
  ["FooSoft/vim-argwrap"] = {
    vim.cmd([[
      let argwrap_tail_comma = 1
    ]])
  },

  -- remove plugins
  ["folke/which-key.nvim"] = false,
}

return plugins
