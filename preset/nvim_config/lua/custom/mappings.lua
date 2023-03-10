---@type MappingsConfig
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<Bslash>"] = { "<cmd> :wincmd w<CR>", "next window" },
    ["<leader>F"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["<leader>w"] = { "<cmd> :ArgWrap<CR>", "do ArgWrap" },
  },
}

-- more keybinds!

return M
