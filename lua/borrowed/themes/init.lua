local Collect = require("borrowed.lib.collect")

local M = {}

---@class (exact) ThemeDefinition
---@field meta ThemeMeta
---@field palette ThemePalette
---@field spec ThemeSpec

---@type table<THEMES, ThemeDefinition>
M.curr_defs = {}

function M:reset()
  self.curr_defs = {}
end

---@enum THEMES
M.THEMES = {
  mayu = "mayu",
  shin = "shin",
}

---@param theme THEMES
---@return ThemeDefinition
local function curr_theme_def(theme)
  if M.curr_defs[theme] then
    return M.curr_defs[theme]
  end

  if theme == M.THEMES.mayu then
    local def = require("borrowed.themes.definitions.mayu")
    M.curr_defs[theme] = Collect.deep_copy(def)
    return M.curr_defs[theme]
  elseif theme == M.THEMES.shin then
    local def = require("borrowed.themes.definitions.shin")
    M.curr_defs[theme] = Collect.deep_copy(def)
    return M.curr_defs[theme]
  else
    require("borrowed.lib.log").error(
      string.format("borrowed.nvim error: tried to load an unknown theme definition: %s", theme)
    )
    return {}
  end
end

---Get a processed theme
---@param theme THEMES
---@return ThemeMeta
---@return ThemePalette
---@return ThemeSpec
function M:get(theme)
  local def = curr_theme_def(theme)
  local meta = def.meta
  local pal = def.palette
  local spec = def.spec

  local is_vim_color = require("borrowed.lib.highlight").is_vim_color

  for key_group, val_group in pairs(spec) do
    for key_member, val_member in pairs(val_group) do
      if is_vim_color(val_member) then
        spec[key_group][key_member] = val_member
      else
        spec[key_group][key_member] = pal[val_member]
      end
    end
  end

  return meta, pal, spec
end

---Override(s) theme palette(s) or adds new colors
---Assumes the provided values to be valid hex colors
---Has to be called first before other override methods
---@param ovrs MaybeThemePalettesConfig
function M:override_palettes(ovrs)
  if ovrs.all then
    for _, theme in pairs(M.THEMES) do
      local pal = curr_theme_def(theme).palette

      for ok, ov in pairs(ovrs.all) do
        pal[ok] = ov
      end
    end
  end

  for name_theme, conf_theme in pairs(ovrs) do
    if name_theme ~= "all" then
      local pal = curr_theme_def(name_theme).palette

      for ok, ov in pairs(conf_theme) do
        pal[ok] = ov
      end
    end
  end
end

---Override(s) theme spec(s)
---Assumes the provided values to be valid hex colors or valid palette color names
---Has to be called right after calling the palette override method
---@param ovrs MaybeThemeSpecsConfig
function M:override_specs(ovrs)
  ---@param theme THEMES
  ---@param ovr MaybeThemeSpec
  local apply_spec_ovrs = function(theme, ovr)
    local def = curr_theme_def(theme)
    local spec = def.spec

    for key_group, val_group in pairs(ovr) do
      for key_member, val_member in pairs(val_group) do
        spec[key_group][key_member] = val_member
      end
    end
  end

  if ovrs.all then
    for _, theme in pairs(M.THEMES) do
      apply_spec_ovrs(theme, ovrs.all)
    end
  end

  for theme, ovr in pairs(ovrs) do
    if theme ~= "all" then
      apply_spec_ovrs(theme, ovr)
    end
  end
end

return M
