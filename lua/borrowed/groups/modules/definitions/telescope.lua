-- https://github.com/nvim-telescope/telescope.nvim

local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  local diff = spec.diff

  -- stylua: ignore
  ---@type Module
  return {
    TelescopeNormal         = { link = "Normal" },
    TelescopeResultsNormal  = { link = "FloatBorder" },
    TelescopeTitle          = { link = "FloatBorder" },
    TelescopeBorder         = { link = "FloatBorder" },
    TelescopeSelectionCaret = { link = "FloatBorder" },
    TelescopeSelection      = { fg = pal.plain, bg = pal.sheet },
    TelescopeMatching       = { fg = pal.extra },
    TelescopePromptCounter  = { link = "FloatBorder" },
    TelescopePromptPrefix   = { link = "FloatBorder" },

    TelescopeResultsDiffAdd       = { fg = diff.add },
    TelescopeResultsDiffChange    = { fg = diff.changed },
    TelescopeResultsDiffDelete    = { fg = diff.removed },
    TelescopeResultsDiffUntracked = { fg = diff.add },
  }
end

return M
