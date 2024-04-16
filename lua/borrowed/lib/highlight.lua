local M = {}

---Turns a string into a table representing nvim hl styles
---@param style? string
---@return table<string,any>
function M.parse_style(style)
  if not style or style == "NONE" then
    return {}
  end

  local result = {}
  for token in string.gmatch(style, "([^,]+)") do
    result[token] = true
  end

  return result
end

---Determines if a string is a valid vim color
---@param color string
---@return boolean
function M.is_vim_color(color)
  return string.sub(color, 1, 1) == "#" or color == "NONE"
end

return M
