-- https://github.com/myypo/compass.nvim

local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  -- stylua: ignore
  ---@type Module
  return {
    CompassRecordPast            = {},
    CompassRecordPastSign        = { fg = pal.blanket, style = "bold" },
    CompassRecordClosePast       = { fg = pal.yell, bg = pal.blanket, style = "bold" },
    CompassRecordClosePastSign   = { fg = pal.yell, style = "bold" },
    CompassRecordFuture          = {},
    CompassRecordFutureSign      = { fg = pal.blanket,  style = "bold" },
    CompassRecordCloseFuture     = { fg = pal.extra, bg = pal.blanket,  style = "bold" },
    CompassRecordCloseFutureSign = { fg = pal.extra, style = "bold" },

    CompassHintOpen       = { link = "Visual" },
    CompassHintOpenPath   = { link = "Visual" },
    CompassHintFollow     = { link = "Visual" },
    CompassHintFollowPath = { link = "Visual" },
  }
end

return M
