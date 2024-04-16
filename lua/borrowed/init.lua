local Config = require("borrowed.config")
local Fs = require("borrowed.lib.fs")

local M = {}

---@return unknown?
local function read_file(filepath)
  local file = io.open(filepath, "r")
  if file then
    local content = file:read()
    file:close()
    return content
  end
end

local function write_file(filepath, content)
  local file = io.open(filepath, "wb")
  if file then
    file:write(content)
    file:close()
  end
end

function M.compile_plugin()
  require("borrowed.lib.log").clear()
  local Themes = require("borrowed.themes")

  if Config.overrides.palettes then
    Themes:override_palettes(Config.overrides.palettes)
  end
  if Config.overrides.specs then
    Themes:override_specs(Config.overrides.specs)
  end
  if Config.overrides.groups then
    require("borrowed.groups"):override_groups(Config.overrides.groups, Config.overrides.strategy)
  end

  local compiler = require("borrowed.compiler")
  local themes = Themes.THEMES
  for _, v in pairs(themes) do
    compiler.compile(v)
  end
end

-- Avold g:colors_name reloading
local lock = false
local did_setup = false

---Plugin entrypoint
---@param theme THEMES
function M.load(theme)
  if lock then
    return
  end

  if not did_setup then
    M.setup()
  end

  local _, compiled_filename = Config:get_compiled_info(theme)
  lock = true

  local compiled = loadfile(compiled_filename)
  if compiled then
    compiled()
  else
    M.compile_plugin()
    compiled = loadfile(compiled_filename)
  end

  lock = false
end

---Mutates the internal state of config merging the user config with the existing one
---@param user_conf? MaybeConfig
local function apply_user_conf(user_conf)
  if user_conf then
    Config:extend_config(user_conf)
  end
end

---Setup function for the user to configure the plugin with
---@param user_conf? MaybeConfig
function M.setup(user_conf)
  did_setup = true

  apply_user_conf(user_conf)

  Fs.ensure_dir(Config.compile_path)

  local cached_path = Fs.join_paths(Config.compile_path, "cache")
  local cached = read_file(cached_path)

  -- Get path of .git folder of the plugin
  local git_path = Fs.join_paths(debug.getinfo(1).source:sub(2, -23), ".git")
  local git = vim.fn.getftime(git_path)
  local hash = require("borrowed.lib.hash")(user_conf) .. (git == -1 and git_path or git)

  if cached ~= hash then
    M.compile_plugin()
    write_file(cached_path, hash)
  end
end

return M
