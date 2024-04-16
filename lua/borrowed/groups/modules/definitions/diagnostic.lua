local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  local diag = spec.diag
  local dbg = spec.diag_bg

  -- stylua: ignore
  ---@type Module
  return {
    DiagnosticError            = { fg = diag.error },
    DiagnosticWarn             = { fg = diag.warn },
    DiagnosticInfo             = { fg = diag.info },
    DiagnosticHint             = { fg = diag.hint },
    DiagnosticOk               = { fg = diag.ok },

    DiagnosticSignError        = { link = "DiagnosticError" },
    DiagnosticSignWarn         = { link = "DiagnosticWarn" },
    DiagnosticSignInfo         = { link = "DiagnosticInfo" },
    DiagnosticSignHint         = { link = "DiagnosticHint" },
    DiagnosticSignOk           = { link = "DiagnosticOk" },

    DiagnosticVirtualTextError = { fg = diag.error, bg = mod.background_enable and dbg.error or "NONE" },
    DiagnosticVirtualTextWarn  = { fg = diag.warn, bg = mod.background_enable and dbg.warn or "NONE" },
    DiagnosticVirtualTextInfo  = { fg = diag.info, bg = mod.background_enable and dbg.info or "NONE" },
    DiagnosticVirtualTextHint  = { fg = diag.hint, bg = mod.background_enable and dbg.hint or "NONE" },
    DiagnosticVirtualTextOk    = { fg = diag.ok, bg = mod.background_enable and dbg.ok or "NONE" },

    DiagnosticUnderlineError   = { style = "undercurl", sp = diag.error },
    DiagnosticUnderlineWarn    = { style = "undercurl", sp = diag.warn },
    DiagnosticUnderlineInfo    = { style = "undercurl", sp = diag.info },
    DiagnosticUnderlineHint    = { style = "undercurl", sp = diag.hint },
    DiagnosticUnderlineOk      = { style = "undercurl", sp = diag.ok },
  }
end

return M
