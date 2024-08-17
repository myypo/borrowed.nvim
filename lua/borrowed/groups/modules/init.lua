local Collect = require("borrowed.lib.collect")
local Config = require("borrowed.config")

local M = {}

---@enum ModuleNames
M.ModuleNames = {
  cmp = "cmp",
  compass = "compass",
  dap_ui = "dap_ui",
  diagnostic = "diagnostic",
  flash = "flash",
  gitsigns = "gitsigns",
  lazy = "lazy",
  semantic_tokens = "semantic_tokens",
  native_lsp = "native_lsp",
  telescope = "telescope",
  treesitter = "treesitter",
}

---Optional configuraion of a colorscheme module responsible for other plugin highlights
---@class ModuleConfig
---@field enable? boolean
---@field background_enable? boolean

---@alias Module table<string, GroupBody>

---@param pal ThemePalette
---@param spec ThemeSpec
---@return Module
function M.get(pal, spec)
  local enable_by_default = Config.module_default
  local mods_conf = Config.modules

  ---@param mod_name ModuleNames
  ---@return Module?
  local get = function(mod_name)
    local opts = mods_conf[mod_name]

    local enable = opts.enable == nil and enable_by_default or opts.enable
    if not enable then
      return
    end

    -- WARN: Should never fail
    ---@type Module
    return require("borrowed.groups.modules.definitions." .. mod_name).get(pal, spec, opts)
  end

  ---@type Module
  local result_modules = {}
  for _, mod_name in pairs(M.ModuleNames) do
    local new_mod = get(mod_name)
    if new_mod then
      result_modules = Collect.deep_extend(result_modules, new_mod)
    end
  end

  return result_modules
end

return M
