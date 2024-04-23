local Colors = require("borrowed.lib.colors")
local Hash = require("borrowed.lib.hash")

describe("Hash", function()
  it("should produce same result with different table order", function()
    local t1 = { Normal = { bg = "#192330", fg = "#cdcecf" } }
    local t2 = { Normal = { fg = "#cdcecf", bg = "#192330" } }

    assert.same(Hash(t1), Hash(t2))
  end)

  it("should understand booleans", function()
    local t1 = {
      transparent = false,
      dim_inactive = false,
      module_default = true,
      inverse = {
        match_paren = false,
        visual = false,
        search = false,
      },
    }
    local t2 = {
      transparent = true,
      dim_inactive = false,
      module_default = false,
      inverse = {
        match_paren = true,
        visual = false,
        search = false,
      },
    }

    assert.are_not_same(Hash(t1), Hash(t2))
  end)
end)

describe("Colors", function()
  it("should correctly brighten when provided with positive power", function()
    local color = Colors.change_brightness("#808080", 20)

    assert.same("#999999", color)
  end)

  it("should correctly darken when provided with negative power", function()
    local color = Colors.change_brightness("#808080", -20)

    assert.same("#666666", color)
  end)

  it("should correctly handle extreme positive input", function()
    local color = Colors.change_brightness("#ff80aa", 80)

    assert.same("#ffe6ff", color)
  end)

  it("should correctly handle extreme negative input", function()
    local color = Colors.change_brightness("#21aa12", -73)

    assert.same("#082d04", color)
  end)
end)
