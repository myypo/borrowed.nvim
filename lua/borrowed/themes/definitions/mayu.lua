---@type ThemeMeta
local meta = {
  light = false,
}

-- stylua: ignore
---@type ThemePalette   
local pal = {
  mattress = "#000000",
  sheet    = "#121212",
  blanket  = "#26233a",
  muted    = "#6e6a86",
  subtle   = "#908caa",

  plain    = "#e0def4", -- white
  yell     = "#eb6f92", -- red
  speak    = "#f6c177", -- yellow
  whisper  = "#eba4ac", -- pink
  shy      = "#3e8fb0", -- green
  extra    = "#9ccfd8", -- breeze
}

-- stylua: ignore
---@type ThemeSpec   
local spec = {
  syntax = {
    bracket     = "subtle",
    builtin     = "yell",
    comment     = "muted",
    conditional = "shy",
    const       = "yell",
    dep         = "muted",
    field       = "speak",
    func        = "plain",
    ident       = "whisper",
    keyword     = "shy",
    number      = "yell",
    operator    = "subtle",
    preproc     = "plain",
    regex       = "shy",
    statement   = "shy",
    string      = "shy",
    type        = "speak",
    variable    = "whisper",
  },

  diag = {
    error = "yell",
    warn  = "speak",
    hint  = "extra",
    info  = "shy",
    ok    = "extra",
  },

  diag_bg = {
    error = "blanket",
    warn  = "blanket",
    hint  = "blanket",
    info  = "blanket",
    ok    = "blanket",
  },

  diff = {
    add      = "shy",
    removed  = "yell",
    changed  = "speak",
    conflict = "yell",
    ignored  = "muted",
  },

  cursor = {
    fg = "mattress",
    bg = "#f5dcd8",
  },

  visual = {
    fg        = "mattress",
    bg        = "speak",
    cursor_fg = "mattress",
    cursor_bg = "yell",
  },
}

---@type ThemeDefinition
return { meta = meta, palette = pal, spec = spec }
