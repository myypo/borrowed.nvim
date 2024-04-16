local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  local syn = spec.syntax
  local diag = spec.diag

  -- stylua: ignore
  ---@type Module
  return {
    DapUIVariable                = { link = "Normal" },
    DapUIScope                   = { link = "Keyword" },
    DapUIType                    = { link = "Type" },
    DapUIValue                   = { fg = syn.variable },
    DapUIModifiedValue           = { fg = syn.variable, style = "underline" },
    DapUIDecoration              = { link = "Keyword" },
    DapUIThread                  = { link = "String" },
    DapUIStoppedThread           = { link = "Keyword" },
    DapUIFrameName               = { link = "Normal" },
    DapUISource                  = { link = "Keyword" },
    DapUILineNumber              = { link = "Number" },
    DapUIFloatBorder             = { link = "FloatBorder" },
    DapUIWatchesEmpty            = { fg = diag.error },
    DapUIWatchesValue            = { fg = diag.warn },
    DapUIWatchesError            = { fg = diag.error },
    DapUIBreakpointsPath         = { link = "Keyword" },
    DapUIBreakpointsInfo         = { fg = diag.info },
    DapUIBreakpointsCurrentLine  = { fg = syn.variable, style = "bold" },
    DapUIBreakpointsLine         = { link = "DapUILineNumber" },
    DapUIBreakpointsDisabledLine = { fg = syn.comment },
  }
end

return M
