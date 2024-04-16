local M = {}

if jit ~= nil then
  M.is_windows = jit.os == "Windows"
else
  M.is_windows = package.config:sub(1, 1) == "\\"
end

---@return string
function M.get_tmp_dir()
  return M.is_windows and os.getenv("TMP") or "/tmp"
end

---@return string
function M.get_separator()
  if M.is_windows then
    return "\\"
  end
  return "/"
end

---@param ... string
---@return string
function M.join_paths(...)
  local separator = M.get_separator()
  return table.concat({ ... }, separator)
end

---@param path string
---@return boolean
function M.exists(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

---@param path string
function M.ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end
end

---@return string
local function vim_cache_home()
  if M.is_windows then
    return M.join_paths(vim.fn.expand("%localappdata%"), "Temp", "vim")
  end
  local xdg = os.getenv("XDG_CACHE_HOME")
  local root = xdg or vim.fn.expand("$HOME/.cache")
  return M.join_paths(root, "vim")
end

M.cache_home = vim.fn.stdpath("cache") or vim_cache_home()

return M
