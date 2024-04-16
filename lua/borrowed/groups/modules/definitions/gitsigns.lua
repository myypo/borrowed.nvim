-- https://github.com/lewis6991/gitsigns.nvim

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
    GitSignsAdd    = { fg = diff.add }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = diff.changed }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = diff.removed }, -- diff mode: Deleted line |diff.txt|
  }
end

return M
