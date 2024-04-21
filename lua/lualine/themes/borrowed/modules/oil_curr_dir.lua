---@param decor string
---@return table?
return function(decor)
  if require("lazy.core.config").plugins["oil.nvim"] == nil then
    return
  end

  return {
    function()
      return require("oil").get_current_dir()
    end,
    cond = function()
      local oil_loadead = require("lazy.core.config").plugins["oil.nvim"]._.loaded ~= nil
      if oil_loadead then
        return require("oil").get_current_dir() ~= nil
      end
      return false
    end,
    color = function()
      return { fg = decor, gui = "bold" }
    end,
  }
end
