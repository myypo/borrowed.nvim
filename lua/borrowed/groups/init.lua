local Collect = require("borrowed.lib.collect")

local THEMES = require("borrowed.themes").THEMES

local M = {}

---@class GroupBody
---@field fg? string
---@field bg? string
---@field sp? string
---@field style? string
---@field link? string

---@alias Group table<string, GroupBody>

---@type table<THEMES, Group>
M.curr_ovrs = {}
---@type OverridesStrategy
M.curr_strategy_ovrs = "force"

function M:reset()
  self.curr_ovrs = {}
  self.curr_strategy_ovrs = "force"
end

---Override(s) theme highlight group(s)
---Assumes the provided values to be valid hex colors or valid palette color names
---Has to be called last after all other override methods
---@param ovrs MaybeGroupsConfig
---@param strategy_ovrs OverridesStrategy
function M:override_groups(ovrs, strategy_ovrs)
  self.curr_strategy_ovrs = strategy_ovrs

  if ovrs.all then
    for _, theme in pairs(THEMES) do
      self.curr_ovrs[theme] = ovrs.all
    end
  end

  for theme, ovr in pairs(ovrs) do
    if theme ~= "all" then
      self.curr_ovrs[theme] = ovr
    end
  end
end

---Recursively follows link field returning a group without it
---@param groups Group
---@param linked GroupBody
---@return GroupBody
local function get_linked_group(groups, linked)
  return linked.link and get_linked_group(groups, groups[linked.link]) or linked
end

---Overrides groups in the 'merge' mode
---@param defaults Group
---@param ovrs Group
local function merge_groups(defaults, ovrs)
  ---@type Group
  local link_ovrs = {}
  ---@type Group
  local literal_ovrs = {}
  for ok, ov in pairs(ovrs) do
    if not defaults[ok] then
      defaults[ok] = {} -- makes it possible for user to add arbitary groups
    end

    if ov.link then
      link_ovrs[ok] = ov
    else
      literal_ovrs[ok] = ov
    end
  end

  for ok, ov in pairs(literal_ovrs) do
    if defaults[ok].link then
      local linked_group = get_linked_group(defaults, defaults[ok])
      for key_hl, val_hl in pairs(linked_group) do
        defaults[ok][key_hl] = val_hl
      end
      defaults[ok].link = nil
    end

    for key_hl, val_hl in pairs(ov) do
      defaults[ok][key_hl] = val_hl
    end
  end

  for ok, ov in pairs(link_ovrs) do
    local not_link_key = function(key)
      return key ~= "link"
    end
    -- if we can't just directly link, merge with the linked group values
    if Collect.tablelen(ov) > 1 or Collect.tablelen(defaults[ok], not_link_key) > 0 then
      local linked_group = get_linked_group(defaults, defaults[ov.link])
      for key_hl, val_hl in pairs(linked_group) do
        ov[key_hl] = val_hl
      end
      ov.link = nil
    end

    for key_hl, val_hl in pairs(ov) do
      defaults[ok][key_hl] = val_hl
    end
  end
end

---@param theme THEMES
---@param pal ThemePalette
---@param spec ThemeSpec
---@return Group
function M:get(theme, pal, spec)
  local var_ovrs = self.curr_ovrs[theme]
  if var_ovrs then
    local is_vim_color = require("borrowed.lib.highlight").is_vim_color

    for group_key, group_body in pairs(var_ovrs) do
      if group_body.fg and not is_vim_color(group_body.fg) then
        var_ovrs[group_key].fg = pal[group_body.fg]
      end
      if group_body.bg and not is_vim_color(group_body.bg) then
        var_ovrs[group_key].bg = pal[group_body.bg]
      end
      if group_body.sp and not is_vim_color(group_body.sp) then
        var_ovrs[group_key].sp = pal[group_body.sp]
      end
    end
  end

  local editor = require("borrowed.groups.editor").get(pal, spec)
  local syntax = require("borrowed.groups.syntax").get(pal, spec)
  local modules = require("borrowed.groups.modules").get(pal, spec)

  local all_groups = Collect.deep_extend(editor, syntax, modules)
  if var_ovrs then
    if self.curr_strategy_ovrs == "merge" then
      merge_groups(all_groups, var_ovrs)
    else
      for ok, ov in pairs(var_ovrs) do
        all_groups[ok] = ov
      end
    end
  end

  return all_groups
end

return M
