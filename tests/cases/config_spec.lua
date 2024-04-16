local Borrowed = require("borrowed")
local Collect = require("borrowed.lib.collect")
local Config = require("borrowed.config")

---@type Config
local default_config = Collect.deep_copy(Config)

describe("Config", function()
  before_each(function()
    Config:reset()
  end)

  it("should produce default config when no setup is called", function()
    assert.table(Config)
  end)

  it("should produce default config when setup is called with nothing passed", function()
    Borrowed.setup()

    assert.same(default_config, Config)
  end)

  it("should produce default config when setup is called with an empty table", function()
    Borrowed.setup({})

    assert.same(default_config, Config)
  end)

  it(
    "should react to updates to the options main body without affecting unrelated fields",
    function()
      Borrowed.setup({ dim_inactive = true })

      assert.is_true(Config.dim_inactive)

      assert.same(default_config.modules, Config.modules)
      assert.same(default_config.styles, Config.styles)
      assert.same(default_config.inverse, Config.inverse)
    end
  )

  it(
    "should react to updates to the options subtable bodies without affecting unrelated fields",
    function()
      Borrowed.setup({
        styles = { comments = "italic" },
        modules = { native_lsp = { background_enable = false } },
      })

      assert.same("italic", Config.styles.comments)
      assert.is_not_true(Config.modules.native_lsp.background_enable)

      assert.same(default_config.compile_path, Config.compile_path)
      assert.same(default_config.inverse, Config.inverse)
    end
  )

  it("should react to override updates", function()
    local ovrs = {
      ---@type OverridesConfig
      overrides = {
        strategy = "merge",
        palettes = {
          all = { yell = "#b72c26" },
          mayu = { mattress = "#161616", shy = "#678362" },
        },
        specs = {
          all = { syntax = { bracket = "#161616", func = "speak" } },
          mayu = { diff = { add = "extra" } },
        },
        groups = {
          all = { Constant = { fg = "speak" } },
          mayu = { String = { style = "italic" } },
        },
      },
    }
    Borrowed.setup(ovrs)

    assert.same(ovrs.overrides, Config.overrides)
    assert.same("#161616", Config.overrides.palettes.mayu.mattress)
  end)
end)
