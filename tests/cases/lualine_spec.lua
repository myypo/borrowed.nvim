local Lualine = require("lualine.themes.borrowed")

describe("Lualine", function()
  before_each(function()
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#111111" })
    vim.api.nvim_set_hl(0, "diffAdded", { fg = "#222222" })
    vim.api.nvim_set_hl(0, "diffChanged", { fg = "#333333" })
    vim.api.nvim_set_hl(0, "diffRemoved", { fg = "#444444" })
  end)

  it("should load without running into errors with only lazy and lualine installed", function()
    Lualine.setup()
  end)
end)
