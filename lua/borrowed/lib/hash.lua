-- https://theartincode.stanis.me/008-djb2/
---@param s any
---@return integer
local function djb2(s)
  local h = 5381
  for i = 1, #s do
    h = bit.lshift(h, 5) + h + string.byte(s, i) -- h * 33 + c
  end
  return h
end

-- Reference: https://github.com/catppuccin/nvim/blob/bad9c23f12944683cd11484d9570560849efc101/lua/catppuccin/lib/hashing.lua
---@param x any
---@return string | integer
local function hash(x)
  local t = type(x)
  if t == "table" then
    local h = 0
    for k, v in next, x do
      h = bit.bxor(h, djb2(k .. hash(v)))
    end
    return h
  elseif t == "function" then
    return djb2(string.dump(x))
  end
  return tostring(x)
end

return hash
