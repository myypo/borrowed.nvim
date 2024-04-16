local M = {}

---Get the number of keys in a map-like table
---@generic T
---@param obj table<T, any>
---@param func? fun(value: T): boolean Key filter function
---@return integer
function M.tablelen(obj, func)
  local count = 0
  for key, _ in pairs(obj) do
    if not func or func and func(key) then
      count = count + 1
    end
  end

  return count
end

---Merges recursively two or more map-like tables.
---@param ... table<any,any> Two or more map-like tables.
---@return table<any,any> Merged table
function M.deep_extend(...)
  local lhs = {}
  for _, rhs in ipairs({ ... }) do
    for k, v in pairs(rhs) do
      if type(lhs[k]) == "table" and type(v) == "table" then
        lhs[k] = M.deep_extend(lhs[k], v)
      else
        lhs[k] = v
      end
    end
  end

  return lhs
end

---Create a deep copy of an object
---@generic T: any
---@param obj T object to be copied
---@param seen? table internal table keeping track of seen elements
---@return T
function M.deep_copy(obj, seen)
  if type(obj) ~= "table" then
    return obj
  end
  if seen and seen[obj] then
    return seen[obj]
  end

  local s = seen or {}
  local res = {}
  s[obj] = res
  for k, v in pairs(obj) do
    res[M.deep_copy(k, s)] = M.deep_copy(v, s)
  end
  return setmetatable(res, getmetatable(obj))
end

return M
