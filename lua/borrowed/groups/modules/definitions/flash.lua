-- https://github.com/hrsh7th/nvim-cmp

local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  -- stylua: ignore
  ---@type Module
  return {
    FlashLabel    = { fg = pal.yell },
    FlashCurrent  = { fg = pal.speak, style = "bold,underline" },
    FlashMatch    = { fg = pal.plain },
    FlashBackdrop = { fg = pal.muted },
  }
end

return M
