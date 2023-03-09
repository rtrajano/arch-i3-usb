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
  ["andersevenrud/cmp-tmux"] = {},
  ["hrsh7th/nvim-cmp"] = {
    override_options = {
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
            trigger_characters_ft = {} -- { filetype = { '.' } }
          },
        },
      }
    }
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
}

return plugins
