local Collect = require("borrowed.lib.collect")
local Groups = require("borrowed.groups")
local Themes = require("borrowed.themes")

local stub = require("luassert.stub")

describe("Groups", function()
  before_each(function()
    Themes:reset()
    Groups:reset()
  end)

  it("should provide default groups when no overrides were made", function()
    local _, pal, spec = Themes:get("mayu")
    local groups = Groups:get("mayu", pal, spec)

    assert.table(groups)
  end)

  it("should be affected by literal overrides to all themes", function()
    local new_cursor = { bg = "#323232", fg = "#555555" }
    local new_boolean = { fg = "#696969" }
    local new_search = { bg = "NONE" }
    local _, pal, spec = Themes:get("mayu")

    Groups:override_groups({
      all = {
        Cursor = new_cursor,
        Boolean = new_boolean,
        Search = new_search,
      },
    }, "force")
    local groups = Groups:get("mayu", pal, spec)

    assert.same(new_cursor, groups.Cursor)
    assert.same(new_boolean, groups.Boolean)
    assert.same(new_search, groups.Search)
  end)

  it(
    "should be affected by overrides to all themes that use palette color names as values",
    function()
      local _, pal, spec = Themes:get("mayu")
      local pass_new_ident = { sp = "yell" }
      local exp_new_ident = { sp = pal.yell }
      local pass_new_boolean = { bg = "sheet", fg = "#424242" }
      local exp_new_boolean = { bg = pal.sheet, fg = "#424242" }

      Groups:override_groups({
        all = { Identifier = pass_new_ident, Boolean = pass_new_boolean },
      }, "force")
      local groups = Groups:get("mayu", pal, spec)

      assert.same(exp_new_ident, groups.Identifier)
      assert.same(exp_new_boolean, groups.Boolean)
    end
  )

  it("should prioritize overrides to a single theme over the ones to all themes", function()
    local _, pal, spec = Themes:get("mayu")
    local pass_new_comment = { fg = "blanket" }
    local exp_new_comment = { fg = pal.blanket }

    Groups:override_groups({
      all = { Comment = { fg = "#777777", bg = "yell" } },
      mayu = { Comment = pass_new_comment },
    }, "force")
    local groups = Groups:get("mayu", pal, spec)

    assert.same(exp_new_comment, groups.Comment)
  end)

  it("should be affected by overrides in theme palette and spec", function()
    local new_mattress = "#121212"
    local new_yell = "#b72c26"
    local new_error = "NONE"
    local _, pal, spec = Themes:get("mayu")
    local pass_new_type = { fg = "yell", bg = "mattress" }
    local exp_new_type = { fg = new_yell, bg = new_mattress }

    Themes:override_palettes({ mayu = { mattress = new_mattress, yell = new_yell } })
    Themes:override_specs({ mayu = { diag = { error = new_error } } })
    Groups:override_groups({
      mayu = { Type = pass_new_type },
    }, "force")
    local groups = Groups:get("mayu", pal, spec)

    assert.same(exp_new_type, groups.Type)
    assert.same(new_error, groups.Error.fg)
  end)

  it("should correctly apply overrides to module groups with a merge strategy", function()
    local new_mattress = "#121212"
    local new_yell = "#b72c26"
    local _, pal, spec = Themes:get("mayu")
    local old_diag = require("borrowed.groups.modules.definitions.diagnostic").get(pal, spec, {})
    local pass_add_diag_under_err = { bg = "yell", fg = "mattress" }
    local exp_add_diag_under_err =
      Collect.deep_extend({ bg = new_yell, fg = new_mattress }, old_diag.DiagnosticUnderlineError)

    Themes:override_palettes({ all = { mattress = new_mattress, yell = new_yell } })
    Groups:override_groups({
      mayu = { DiagnosticUnderlineError = pass_add_diag_under_err },
    }, "merge")
    local groups = Groups:get("mayu", pal, spec)

    assert.same(exp_add_diag_under_err, groups.DiagnosticUnderlineError)
  end)

  it("should be able to add a new user-defined group with a force strategy", function()
    local _, pal, spec = Themes:get("mayu")
    local group_key = "HelloForceWorld"
    local pass_group_val = { bg = "extra", fg = "#223322" }
    local exp_group_val = { bg = pal.extra, fg = "#223322" }

    Groups:override_groups({
      mayu = { [group_key] = pass_group_val },
    }, "force")
    local groups = Groups:get("mayu", pal, spec)

    assert.same(exp_group_val, groups[group_key])
  end)

  it("should be able to add a new user-defined group with a merge strategy", function()
    local _, pal, spec = Themes:get("mayu")
    local group_key = "HelloMergeWorld"
    local pass_group_val = { bg = "#166969", fg = "extra" }
    local exp_group_val = { bg = "#166969", fg = pal.extra }

    Groups:override_groups({
      mayu = { [group_key] = pass_group_val },
    }, "merge")
    local groups = Groups:get("mayu", pal, spec)

    assert.same(exp_group_val, groups[group_key])
  end)

  it("should merge with the linked style when using the merge strategy", function()
    local _, pal, spec = Themes:get("mayu")
    local string_group = { fg = pal.extra, style = "underline" }
    local char_group = { link = "String" }
    ---@type Group
    local stub_groups = { String = string_group, Character = char_group }
    local stub_editor = stub(require("borrowed.groups.syntax"), "get", stub_groups)

    local new_char_bg = "#175614"
    local pass_add_char = { bg = new_char_bg, fg = "speak" }
    local exp_add_char = { bg = new_char_bg, fg = pal.speak, style = "underline" }

    Groups:override_groups({
      mayu = { Character = pass_add_char },
    }, "merge")
    local groups = Groups:get("mayu", pal, spec)

    assert.same(exp_add_char, groups.Character)

    stub_editor:revert()
  end)

  it(
    "should merge with the linked style using the merge strategy when there is an extisting nested link",
    function()
      local _, pal, spec = Themes:get("mayu")
      local search_group = { fg = pal.mattress, bg = pal.yell }
      local inc_search_group = { link = "Search" }
      local cur_search_group = { link = "IncSearch" }
      ---@type Group
      local stub_groups =
        { Search = search_group, IncSearch = inc_search_group, CurSearch = cur_search_group }
      local stub_editor = stub(require("borrowed.groups.editor"), "get", stub_groups)

      local pass_add_cur_search = { bg = "whisper" }
      local exp_add_cur_search = { fg = search_group.fg, bg = pal.whisper }

      Groups:override_groups({
        all = { CurSearch = pass_add_cur_search },
      }, "merge")
      local groups = Groups:get("mayu", pal, spec)

      assert.same(exp_add_cur_search, groups.CurSearch)

      stub_editor:revert()
    end
  )

  it(
    "should merge with the linked style using the merge strategy inheriting the changes made to the linked highlight",
    function()
      local _, pal, spec = Themes:get("mayu")
      local comment_group = { fg = "#ff0000" }
      local special_comment_group = { link = "Comment" }
      local bold_group = { style = "bold" }
      ---@type Group
      local stub_groups =
        { Comment = comment_group, SpecialComment = special_comment_group, Bold = bold_group }
      local stub_editor = stub(require("borrowed.groups.syntax"), "get", stub_groups)

      local new_comment_bg = "#222222"
      local pass_comment = { bg = new_comment_bg }
      local exp_comment = { fg = comment_group.fg, bg = new_comment_bg }
      local pass_bold = { link = "SpecialComment" }
      local exp_bold = { fg = comment_group.fg, bg = exp_comment.bg, style = bold_group.style }

      Groups:override_groups({
        all = { Bold = pass_bold, Comment = pass_comment },
      }, "merge")
      local groups = Groups:get("mayu", pal, spec)

      assert.same(exp_comment, groups.Comment)
      assert.same(exp_bold, groups.Bold)

      stub_editor:revert()
    end
  )
end)
