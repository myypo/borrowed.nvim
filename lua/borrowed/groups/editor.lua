local Config = require("borrowed.config")

local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@return Group
function M.get(pal, spec)
  local trans = Config.transparent
  local inactive = Config.dim_inactive
  local inv = Config.inverse
  local conf_curs = Config.cursor

 -- stylua: ignore
 ---@type Group
 local editor = {
    BorrowedCursorVisual = conf_curs.enable and conf_curs.visual.enable and { fg = spec.visual.cursor_fg, bg = spec.visual.cursor_bg } or {}, -- how cursor looks in the visual mode
    Cursor           = conf_curs.enable and { fg = spec.cursor.fg, bg = spec.cursor.bg } or {}, -- character under the cursor (regular cursor highlights are actually not used until specified :help 'guicursor')
    ColorColumn      = { bg = "NONE" }, -- used for the columns set with 'colorcolumn'
    Conceal          = { fg = "NONE" }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    lCursor          = { link = "Cursor" }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM         = { link = "Cursor" }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn     = { link = "CursorLine" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine       = { bg = pal.blanket }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory        = { fg = pal.whisper }, -- directory names (and other special names in listings)
    DiffAdd          = { fg = spec.diff.add, bg = pal.sheet }, -- diff mode: Added line |diff.txt|
    DiffChange       = { fg = spec.diff.changed, bg = pal.sheet }, -- diff mode: Changed line |diff.txt|
    DiffDelete       = { fg = spec.diff.removed, bg = pal.sheet }, -- diff mode: Deleted line |diff.txt|
    DiffText         = { fg = spec.diff.changed, bg = pal.sheet }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer      = { fg = pal.blanket }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    ErrorMsg         = { fg = spec.diag.error }, -- error messages on the command line
    WinSeparator     = { fg = pal.blanket }, -- the column separating vertically split windows
    VertSplit        = { link = "WinSeparator" }, -- the column separating vertically split windows
    Folded           = { fg = pal.muted }, -- line used for closed folds
    FoldColumn       = { fg = pal.blanket }, -- 'foldcolumn'
    SignColumn       = { fg = pal.blanket }, -- column where |signs| are displayed
    SignColumnSB     = { link = "SignColumn" }, -- column where |signs| are displayed
    Substitute       = { link = "Search" }, -- |:substitute| replacement text highlighting
    LineNr           = { fg = pal.muted }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr     = { fg = pal.whisper }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen       = { fg = pal.plain, bg = "#403d52", style = inv.match_paren and "reverse" or "NONE" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg          = { fg = pal.plain, style = "bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MoreMsg          = { fg = pal.plain }, -- |more-prompt|
    NonText          = { fg = pal.blanket }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal           = { fg = pal.plain, bg = trans and "NONE" or pal.mattress }, -- normal text
    NormalNC         = { fg = pal.plain, bg = (inactive and pal.sheet) or (trans and "NONE") or pal.mattress  }, -- normal text in non-current windows
    NormalFloat      = { link = "Normal" }, -- Normal text in floating windows.
    FloatBorder      = { fg = pal.whisper }, -- Color of floating windows, such as hover docs
    Pmenu            = { fg = pal.subtle }, -- Popup menu: normal item.
    PmenuSel         = { fg = pal.whisper, style = "bold,underline" }, -- Popup menu: selected item.
    PmenuSbar        = { link = "Pmenu" }, -- Popup menu: scrollbar.
    PmenuThumb       = { bg = pal.whisper }, -- Popup menu: Thumb of the scrollbar.
    Question         = { link = "MoreMsg" }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine     = { link = "CursorLine" }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search           = inv.search and { style = "reverse" } or { fg = pal.mattress, bg = pal.yell }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch        = { link = "Search" }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    CurSearch        = { link = "IncSearch"}, -- Search result under cursor (available since neovim >0.7.0 (https://github.com/neovim/neovim/commit/b16afe4d556af7c3e86b311cfffd1c68a5eed71f)).
    SpecialKey       = { link = "NonText" }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad         = { sp = spec.diag.error, style = "undercurl" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap         = { sp = spec.diag.warn, style = "undercurl" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal       = { sp = spec.diag.info, style = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare        = { sp = spec.diag.info, style = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine       = { fg = pal.muted, bg = pal.sheet }, -- status line of current window
    StatusLineNC     = { fg = pal.muted, bg = pal.blanket }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.

    TabLine          = { fg = pal.subtle, bg = pal.blanket }, -- tab pages line, not active tab page label
    TabLineFill      = { bg = pal.blanket }, -- tab pages line, where there are no labels
    TabLineSel       = { fg = pal.whisper, style = "bold,underline" }, -- tab pages line, active tab page label
    Title            = { fg = pal.plain, style = "bold" }, -- titles for output from ":set all", ":autocmd" etc.
    Visual           = inv.visual and { style = "reverse,bold" } or { fg = spec.visual.fg, bg = spec.visual.bg, style = "bold" }, -- Visual mode selection
    VisualNOS        = { link = "Visual" }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg       = { fg = spec.diag.warn }, -- warning messages
    Whitespace       = { link = "NonText" }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu         = { link = "Pmenu" }, -- current match in 'wildmenu' completion
    WinBar           = { fg = "NONE", bg = "NONE" }, -- Window bar of current window.
    WinBarNC         = { link = "WinBar" }, --Window bar of not-current windows.
 }

  return editor
end

return M
