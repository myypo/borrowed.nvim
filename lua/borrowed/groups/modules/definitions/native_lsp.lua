local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  local syn = spec.syntax

  -- stylua: ignore
  ---@type Module
  return {
    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.
    LspReferenceText  = { bg = pal.blanket }, -- used for highlighting "text" references
    LspReferenceRead  = { bg = pal.blanket }, -- used for highlighting "read" references
    LspReferenceWrite = { bg = pal.blanket }, -- used for highlighting "write" references

    LspCodeLens                 = { fg = pal.subtle }, -- Used to color the virtual text of the codelens
    LspCodeLensSeparator        = { link = "WinSeparator" }, -- Used to color the separator between two or more code lens
    LspSignatureActiveParameter = { link = "PmenuSel" }, -- Used to highlight the active parameter in the signature help

    LspInlayHint = { fg = syn.comment, bg = mod.background_enable and pal.blanket or "NONE" },
  }
end

return M
