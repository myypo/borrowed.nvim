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
