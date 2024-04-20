-- Definitions of a theme specification --
--

---@alias ThemeColor
---| "mattress"
---| "sheet"
---| "blanket"
---| "muted"
---| "subtle"
---| "plain"
---| "yell"
---| "speak"
---| "whisper"
---| "shy"
---| "extra"
---| string

---Colorcheme theme's bindings of highlight groups to palette colors
---@class ThemeSpec
---@field syntax ThemeSpecSyntax
---@field diag ThemeSpecDiagnostic
---@field diag_bg ThemeSpecDiagnosticBg
---@field diff ThemeSpecDiff
---@field cursor ThemeSpecCursor
---@field visual ThemeSpecVisual

---Meta data of a colorscheme theme, with which the end-user is not supposed to directly interact
---@class ThemeMeta
---@field light boolean

---Code syntax related bindings of a colorscheme theme
---@class ThemeSpecSyntax
---@field bracket ThemeColor     -- Brackets and Punctuation
---@field builtin ThemeColor     -- Builtin language vars, functions and special consts
---@field comment ThemeColor     -- Comment
---@field conditional ThemeColor -- Conditional and loop
---@field const ThemeColor       -- Constants, imports and booleans
---@field dep ThemeColor         -- Deprecated
---@field field ThemeColor       -- Field
---@field func ThemeColor        -- Functions and Titles
---@field ident ThemeColor       -- Identifiers
---@field keyword ThemeColor     -- Keywords
---@field number ThemeColor      -- Numbers
---@field operator ThemeColor    -- Operators
---@field preproc ThemeColor     -- PreProc
---@field regex ThemeColor       -- Regex
---@field statement ThemeColor   -- Statements
---@field string ThemeColor      -- Strings
---@field type ThemeColor        -- Types
---@field variable ThemeColor    -- Variables

---Definitions of how colorscheme theme should color various diagnostics' text
---@class ThemeSpecDiagnostic
---@field error ThemeColor
---@field warn ThemeColor
---@field info ThemeColor
---@field hint ThemeColor
---@field ok ThemeColor

---Definitions of how colorscheme theme should color various diagnostics' background
---@class ThemeSpecDiagnosticBg
---@field error ThemeColor
---@field warn ThemeColor
---@field info ThemeColor
---@field hint ThemeColor
---@field ok ThemeColor

---Git and file change related bindings of a colorscheme theme
---@class ThemeSpecDiff
---@field add ThemeColor
---@field removed ThemeColor
---@field changed ThemeColor
---@field conflict ThemeColor
---@field ignored ThemeColor

---Cursor color specificaion
---@class ThemeSpecCursor
---@field fg ThemeColor
---@field bg ThemeColor

---Definitions of how visual mode selection should be highlighted
---@class ThemeSpecVisual
---@field fg ThemeColor
---@field bg ThemeColor
---@field cursor_fg ThemeColor
---@field cursor_bg ThemeColor

--
-- Palette --
--

---Color palette of the colorscheme theme
---@class ThemePalette
---Monochrome palette for UI elements and non-important text like comments
---@field mattress string  -- Primary background color
---@field sheet string     -- Very subtle large UI elements over the primary bg
---@field blanket string   -- Normal UI elements over the primary bg
---@field muted string     -- Text that is less often read, like unused variables
---@field subtle string    -- Subtle but well readable text
---Colors used for syntax highlighting and UI elements that have to stand out
---@field plain string     -- Foreground color used for regular text
---@field yell string      -- The most intense foreground color
---@field speak string     -- Less intense foreground color
---@field whisper string   -- Even less intense foreground color
---@field shy string       -- The least intense foreground color
---@field extra string     -- Extra color that is not used for syntax highlighting
---@field [string]? string -- Optional user-defined colors
