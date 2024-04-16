-- Definitions of optional user config input --
--

---User-provided config
---@class (exact) MaybeConfig
---@field compile_path? string
---@field compile_file_suffix? string
---@field transparent? boolean
---@field dim_inactive? boolean
---@field module_default? boolean
---@field styles? MaybeStylesConfig
---@field inverse? MaybeInverseConfig
---@field cursor? MaybeCursorConfig
---@field modules? MaybeModuleConfigList
---@field overrides? MaybeOverridesConfig

--
-- Styles --
--

---@class MaybeStylesConfig
---@field comments? string
---@field conditionals? string
---@field constants? string
---@field functions? string
---@field keywords? string
---@field numbers? string
---@field operators? string
---@field strings? string
---@field types? string
---@field variables? string

--
-- Inverse --
--

---@class MaybeInverseConfig
---@field match_paren? boolean
---@field visual? boolean
---@field search? boolean

--
-- Cursor --
--

---@class MaybeCursorConfig
---@field enable? boolean
---@field visual? MaybeVisualConfig

---@class MaybeVisualConfig
---@field enable? boolean

--
-- Modules --
--

---@class MaybeModuleConfigList
---@field [ModuleNames]? ModuleConfig

--
-- Overrides --
--

---@class MaybeOverridesConfig
---@field strategy? MaybeOverridesStrategy
---@field palettes? MaybeThemePalettesConfig
---@field specs? MaybeThemeSpecsConfig
---@field groups? MaybeGroupsConfig

---@alias OverridesStrategy "force" | "merge"
---@type OverridesStrategy

---@alias MaybeOverridesStrategy string?

-- ThemePalette

---@class MaybeThemePalettesConfig
---@field all? MaybeThemePalette
---@field [THEMES]? MaybeThemePalette

---@class MaybeThemePalette
---@field mattress? string
---@field sheet? string
---@field blanket? string
---@field muted? string
---@field subtle? string
---@field plain? string
---@field yell? string
---@field speak? string
---@field whisper? string
---@field shy? string
---@field extra? string

-- ThemeSpec

---@class MaybeThemeSpecsConfig
---@field all? MaybeThemeSpec
---@field [THEMES]? MaybeThemeSpec

---@class MaybeThemeSpec
---@field syntax? MaybeThemeSpecSyntax
---@field diag? MaybeThemeSpecDiagnostic
---@field diag_bg? MaybeThemeSpecDiagnosticBg
---@field diff? MaybeThemeSpecDiff
---@field cursor? MaybeThemeSpecCursor
---@field visual? MaybeThemeSpecVisual

---@class MaybeThemeSpecSyntax
---@field bracket? string
---@field builtin? string
---@field comment? string
---@field conditional? string
---@field const? string
---@field dep? string
---@field field? string
---@field func? string
---@field ident? string
---@field keyword? string
---@field number? string
---@field operator? string
---@field preproc? string
---@field regex? string
---@field statement? string
---@field string? string
---@field type? string
---@field variable? string

---@class MaybeThemeSpecDiagnostic
---@field error? string
---@field warn? string
---@field info? string
---@field hint? string
---@field ok? string

---@class MaybeThemeSpecDiagnosticBg
---@field error? string
---@field warn? string
---@field info? string
---@field hint? string
---@field ok? string

---@class MaybeThemeSpecDiff
---@field add? string
---@field removed? string
---@field changed? string
---@field conflict? string
---@field ignored? string

---@class MaybeThemeSpecCursor
---@field fg? string
---@field bg? string

---@class MaybeThemeSpecVisual
---@field fg? string
---@field bg? string
---@field cursor_fg? string
---@field cursor_bg? string

-- Groups

---@class MaybeGroupsConfig
---@field all? Group
---@field [THEMES]? Group
