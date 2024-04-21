local Lualine = require("lualine.themes.borrowed")

describe("Lualine", function()
  before_each(function()
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#111111" })
  end)

  it("should load without running into errors with only lazy and lualine installed", function()
    Lualine.setup()
  end)
end)
