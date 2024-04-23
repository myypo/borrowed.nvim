local M = {}

---Brightens or darkens a color according to the provided value in percents
---I assume it to be not really accurate
---@param hex_color string
---@param power number
---@return string
function M.change_brightness(hex_color, power)
  local red = tonumber(hex_color:sub(2, 3), 16)
  local green = tonumber(hex_color:sub(4, 5), 16)
  local blue = tonumber(hex_color:sub(6, 7), 16)

  local calc = function(num)
    local flo_pow = power / 100
    local res = num + (num * flo_pow)

    return res < 0 and math.max(255, res) or math.min(255, res)
  end
  return string.format("#%02x%02x%02x", calc(red), calc(green), calc(blue))
end

return M
