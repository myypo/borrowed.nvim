local Collect = require("borrowed.lib.collect")
local Themes = require("borrowed.themes")

local mayu_default_pal = Collect.deep_copy(require("borrowed.themes.definitions.mayu")).palette
local mayu_default_meta = Collect.deep_copy(require("borrowed.themes.definitions.mayu")).meta

describe("Theme palette", function()
  before_each(function()
    Themes:reset()
  end)

  it("should provide a default mayu palette when no overrides were made", function()
    local meta, pal, _ = Themes:get("mayu")

    assert.same(mayu_default_meta, meta)
    assert.same(mayu_default_pal, pal)
  end)

  it("should be affected by overrides to all themes", function()
    local new_mattress = "#121212"
    local new_yell = "#b72c26"

    Themes:override_palettes({ all = { mattress = new_mattress, yell = new_yell } })
    local meta, pal, _ = Themes:get("mayu")

    assert.same(new_mattress, pal.mattress)
    assert.same(new_yell, pal.yell)

    assert.same(mayu_default_pal.extra, pal.extra)
    assert.same(mayu_default_meta, meta)
  end)

  it("should be affected by overrides to a single theme", function()
    local new_mattress = "#121212"
    local new_shy = "#678362"

    Themes:override_palettes({ mayu = { mattress = new_mattress, shy = new_shy } })
    local meta, pal, _ = Themes:get("mayu")

    assert.same(new_mattress, pal.mattress)
    assert.same(new_shy, pal.shy)

    assert.same(mayu_default_pal.yell, pal.yell)
    assert.same(mayu_default_meta, meta)
  end)

  it("should prioritize single theme overrides over overrides to everything", function()
    local new_all_mattress = "#121212"
    local new_all_shy = "#678362"
    local new_mayu_mattress = "#333333"
    local new_mayu_yell = "#de4b36"

    Themes:override_palettes({
      mayu = { mattress = new_mayu_mattress, yell = new_mayu_yell },
      all = { mattress = new_all_mattress, shy = new_all_shy },
    })
    local meta, pal, _ = Themes:get("mayu")

    assert.same(new_mayu_mattress, pal.mattress)
    assert.same(new_mayu_yell, pal.yell)
    assert.same(new_all_shy, pal.shy)

    assert.same(mayu_default_pal.extra, pal.extra)
    assert.same(mayu_default_meta, meta)
  end)

  it("should be possible to add user-defined palette colors", function()
    local new_yell = "#555555"
    local new_sun = "#222222"
    local new_breeze = "#111111"

    Themes:override_palettes({
      shin = { new_sun = new_sun, yell = new_yell },
      all = { new_sun = "not_this", new_breeze = new_breeze },
    })
    local _, pal, _ = Themes:get("shin")

    assert.same(new_yell, pal.yell)
    assert.same(new_sun, pal.new_sun)
    assert.same(new_breeze, pal.new_breeze)
  end)
end)

describe("Theme specs", function()
  before_each(function()
    Themes:reset()
  end)

  it("should be affected by overrides to all themes", function()
    local new_bracket = "#1d6e82"
    local new_comment = "#5e9f83"
    local new_add = "#47ad3f"

    Themes:override_specs({
      all = { syntax = { bracket = new_bracket, comment = new_comment }, diff = { add = new_add } },
    })
    local meta, pal, spec = Themes:get("mayu")

    assert.same(new_bracket, spec.syntax.bracket)
    assert.same(new_comment, spec.syntax.comment)
    assert.same(new_add, spec.diff.add)

    assert.same(mayu_default_meta, meta)
    assert.same(mayu_default_pal, pal)
  end)

  it("should be able to apply colors based on palette names", function()
    local new_bracket = "#1d6e82"
    local new_extra = "#ca3afc"
    local new_change = "NONE"

    Themes:override_palettes({
      mayu = { extra = new_extra },
    })
    Themes:override_specs({
      all = {
        syntax = { bracket = new_bracket, variable = "extra" },
        diff = { changed = new_change },
      },
    })
    local meta, pal, spec = Themes:get("mayu")

    assert.same(new_bracket, spec.syntax.bracket)
    assert.same(new_extra, spec.syntax.variable)
    assert.same(new_change, spec.diff.changed)
    assert.same(new_extra, pal.extra)

    assert.same(mayu_default_meta, meta)
    assert.same(mayu_default_pal.yell, pal.yell)
  end)

  it("should prioritize single theme overrides over overrides to everything", function()
    local new_string = "#668227"
    local new_yell = "#ca3afc"

    Themes:override_palettes({
      all = { yell = new_yell },
    })
    Themes:override_specs({
      all = { syntax = { string = new_string, comment = "#555522" } },
      mayu = { syntax = { comment = "yell" } },
    })
    local meta, pal, spec = Themes:get("mayu")

    assert.same(new_string, spec.syntax.string)
    assert.same(new_yell, spec.syntax.comment)
    assert.same(new_yell, pal.yell)

    assert.same(mayu_default_meta, meta)
    assert.same(mayu_default_pal.extra, pal.extra)
  end)

  it("should reflect modification of palette colors in spec", function()
    local _, _, old_spec = Collect.deep_copy(Themes:get("shin"))

    Themes:override_palettes({
      shin = { yell = "#000000", extra = "#111111", blanket = "#222222", shy = "#333333" },
    })
    local _, _, spec = Themes:get("shin")

    assert.are_not_same(spec, old_spec)
  end)

  it("should be possible to use user-defined palette colors to define specs", function()
    local new_solid = "#777777"

    Themes:override_palettes({
      mayu = { new_solid = new_solid },
    })
    Themes:override_specs({
      mayu = { syntax = { statement = "new_solid" } },
      all = { syntax = { statement = "not_this" }, cursor = { fg = "new_solid" } },
    })
    local _, pal, spec = Themes:get("mayu")

    assert.same(new_solid, pal.new_solid)
    assert.same(new_solid, spec.syntax.statement)
    assert.same(new_solid, spec.cursor.fg)
  end)
end)
