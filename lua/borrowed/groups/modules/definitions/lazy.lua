local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  ---@type Module
  return {
    LazyButtonActive = { link = "TabLineSel" },
    LazyDimmed = { link = "LineNr" },
    LazyProp = { link = "LineNr" },
  }
end

return M
