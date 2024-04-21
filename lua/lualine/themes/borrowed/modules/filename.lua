---@param decor string
---@return function
local define_color = function(decor)
  if require("lazy.core.config").plugins["grapple.nvim"] then
    return function()
      if require("grapple").exists() == true then
        return { fg = decor, gui = "bold,underline" }
      end
      return { fg = decor, gui = "bold" }
    end
  end

  return function()
    return { fg = decor, gui = "bold" }
  end
end

---@param decor string
---@return table
return function(decor)
  return {
    "filename",
    cond = function()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    color = define_color(decor),
  }
end
