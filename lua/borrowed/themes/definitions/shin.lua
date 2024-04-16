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

  plain    = "#f7c7b5", -- white
  yell     = "#e7517b", -- red
  speak    = "#f78273", -- orange
  whisper  = "#e0879e", -- pink
  shy      = "#a37e6f", -- brown
  extra    = "#949ae7", -- blue
}

-- stylua: ignore
---@type ThemeSpec   
local spec = {
  syntax = {
    bracket     = "subtle",
    builtin     = "extra",
    comment     = "muted",
    conditional = "yell",
    const       = "extra",
    dep         = "muted",
    field       = "speak",
    func        = "whisper",
    ident       = "plain",
    keyword     = "yell",
    number      = "extra",
    operator    = "subtle",
    preproc     = "whisper",
    regex       = "shy",
    statement   = "yell",
    string      = "shy",
    type        = "speak",
    variable    = "plain",
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
    add      = "extra",
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
    bg        = "shy",
    cursor_fg = "mattress",
    cursor_bg = "extra",
  },
}

---@type ThemeDefinition
return { meta = meta, palette = pal, spec = spec }
