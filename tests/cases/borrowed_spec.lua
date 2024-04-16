local Config = require("borrowed.config")
local Borrowed = require("borrowed")
local Spy = require("luassert.spy")

---@type MaybeConfig
local user_conf = { compile_file_suffix = "_very_unique_compiled_suffix" }

describe("Borrowed init plugin compilation", function()
  local snapshot
  before_each(function()
    snapshot = assert:snapshot()
  end)
  after_each(function()
    snapshot:revert()
  end)

  it("should compile on a new unique setup", function()
    local s = Spy.on(Borrowed, "compile_plugin")

    Borrowed.setup(user_conf)

    assert.spy(s).called(1)
  end)

  it("should not recompile when the same config is reused", function()
    local s = Spy.on(Borrowed, "compile_plugin")

    Borrowed.setup(user_conf)

    assert.spy(s).called(0)
  end)

  it("should recompile when we make a change to the config", function()
    local s = Spy.on(Borrowed, "compile_plugin")

    ---@type MaybeConfig
    local new_inv_conf = { inverse = { match_paren = true, visual = true, search = true } }
    Borrowed.setup(new_inv_conf)

    assert.spy(s).called(1)
    assert.same(new_inv_conf.inverse, Config.inverse)
  end)
end)
