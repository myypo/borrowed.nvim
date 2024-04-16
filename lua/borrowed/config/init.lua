local Collect = require("borrowed.lib.collect")
local Fs = require("borrowed.lib.fs")

---Plugin config where all of the mandatory fields
---are guaranteed to be defined
---@class Config
local defaults = {
  ---@type string
  compile_path = Fs.join_paths(Fs.cache_home, "borrowed"),
  ---@type string
  compile_file_suffix = "_compiled",
  ---@type boolean
  transparent = false,
  ---@type boolean
  dim_inactive = false,

  ---@class StyleConfig
  styles = {
    comments = "NONE",
    conditionals = "NONE",
    constants = "NONE",
    functions = "NONE",
    keywords = "NONE",
    numbers = "NONE",
    operators = "NONE",
    strings = "NONE",
    types = "NONE",
    variables = "NONE",
  },

  ---@class InverseConfig
  inverse = {
    match_paren = false,
    visual = false,
    search = false,
  },

  ---@class CursorConfig
  cursor = {
    enable = true,
    visual = {
      enable = true,
    },
  },

  ---@type boolean
  module_default = true,

  ---@class ModuleConfigList
  ---@field [ModuleNames] ModuleConfig
  modules = {
    cmp = { enable = true },
    dap_ui = { enable = true },
    diagnostic = {
      enable = true,
      background_enable = true,
    },
    flash = { enable = true },
    gitsigns = { enable = true },
    lazy = { enable = true },
    semantic_tokens = { enable = true },
    native_lsp = {
      enable = true,
      background_enable = true,
    },
    telescope = { enable = true },
    treesitter = { enable = true },
  },

  ---@class OverridesConfig
  ---@field strategy OverridesStrategy
  ---@field palettes? MaybeThemePalettesConfig
  ---@field specs? MaybeThemeSpecsConfig
  ---@field groups? MaybeGroupsConfig
  overrides = {
    strategy = "force",
  },
}

local curr_conf = Collect.deep_copy(defaults)

---@class Config
local M = {}

---@param user_conf MaybeConfig
function M:extend_config(user_conf)
  curr_conf = Collect.deep_extend(curr_conf, user_conf)
end

function M:reset()
  curr_conf = Collect.deep_copy(defaults)
end

---@param theme THEMES
---@return string
---@return string
function M:get_compiled_info(theme)
  local output_path = self.compile_path
  local file_suffix = self.compile_file_suffix

  return output_path, Fs.join_paths(output_path, theme .. file_suffix)
end

return setmetatable(M, {
  __index = function(_, key)
    return curr_conf[key]
  end,
})
