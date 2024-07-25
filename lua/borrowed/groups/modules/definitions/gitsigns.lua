-- https://github.com/lewis6991/gitsigns.nvim

local change_brightness = require("borrowed.lib.colors").change_brightness

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
    GitSignsAdd          = { fg = diff.add },
    GitSignsAddInline    = { link = "NONE" },
    GitSignsChange       = { fg = diff.changed },
    GitSignsChangeInline = { link = "NONE" },
    GitSignsDelete       = { fg = diff.removed },
    GitSignsDeleteInline = { link = "NONE" },
  }
end

return M
