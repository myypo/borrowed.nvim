-- https://github.com/hrsh7th/nvim-cmp

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
    CmpDocumentation         = { fg   = pal.plain, bg = pal.mattress },
    CmpDocumentationBorder   = { link = "FloatBorder" },

    CmpItemAbbr              = { fg   = pal.subtle },
    CmpItemAbbrDeprecated    = { fg   = syn.dep, style = "strikethrough" },

    CmpItemAbbrMatch         = { fg   = pal.plain, style = "bold" },
    CmpItemAbbrMatchFuzzy    = { link = "CmpItemAbbrMatch" },

    CmpItemMenu              = { fg   = "NONE", bg = "NONE" },

    CmpItemKindDefault       = { fg   = pal.yell },

    CmpItemKindText          = { link = "String" },

    CmpItemKindKeyword       = { link = "Keyword" },

    CmpItemKindVariable      = { link = "Identifier" },
    CmpItemKindReference     = { link = "Identifier" },
    CmpItemKindConstant      = { link = "Constant" },
    CmpItemKindValue         = { link = "Constant" },

    CmpItemKindFunction      = { link = "Function" },
    CmpItemKindMethod        = { link = "Function" },
    CmpItemKindConstructor   = { link = "Function" },

    CmpItemKindClass         = { link = "Type" },
    CmpItemKindStruct        = { link = "Type" },
    CmpItemKindInterface     = { link = "Type" },
    CmpItemKindEnum          = { link = "Type" },
    CmpItemKindUnit          = { link = "Type" },

    CmpItemKindTypeParameter = { link = "Type" },

    CmpItemKindProperty      = { link = "Type" },
    CmpItemKindField         = { link = "Type" },


    CmpItemKindEnumMember    = { link = "Constant" },
    CmpItemKindOperator      = { link = "Keyword" },

    CmpItemKindModule        = { fg = pal.extra },

    CmpItemKindFolder        = { fg = pal.extra },
    CmpItemKindFile          = { fg = pal.shy },

    CmpItemKindEvent         = { fg = pal.extra },
    CmpItemKindSnippet       = { fg = pal.extra },
  }
end

return M
