local Config = require("borrowed.config")
local Fs = require("borrowed.lib.fs")

local parse_styles = require("borrowed.lib.highlight").parse_style
local fmt = string.format

local M = {}

local function inspect(t)
  local list = {}
  for k, v in pairs(t) do
    local q = type(v) == "string" and [["]] or ""
    table.insert(list, fmt([[%s = %s%s%s]], k, q, v, q))
  end

  table.sort(list)
  return fmt([[{ %s }]], table.concat(list, ", "))
end

---@param link string
local function should_link(link)
  return link and link ~= ""
end

---@param theme THEMES
function M.compile(theme)
  local meta, palette, spec = require("borrowed.themes"):get(theme)

  local groups = require("borrowed.groups"):get(theme, palette, spec)

  local background = meta.light and "light" or "dark"

  local lines = {
    fmt(
      [[
return string.dump(function()
local h = vim.api.nvim_set_hl
if vim.g.colors_name then vim.cmd("hi clear") end
vim.o.termguicolors = true
vim.g.colors_name = "%s"
vim.o.background = "%s"
    ]],
      theme,
      background
    ),
  }

  -- TODO: can be extracted into a separate module and expanded
  if Config.cursor.enable then
    if Config.cursor.visual.enable then
      table.insert(
        lines,
        [[vim.o.guicursor = "n-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,v:block-BorrowedCursorVisual"]]
      )
    end
  end

  for name, values in pairs(groups) do
    if should_link(values.link) then
      table.insert(lines, fmt([[h(0, "%s", { link = "%s" })]], name, values.link))
    else
      local op = parse_styles(values.style)
      op.bg = values.bg
      op.fg = values.fg
      op.sp = values.sp
      table.insert(lines, fmt([[h(0, "%s", %s)]], name, inspect(op)))
    end
  end

  table.insert(lines, "end)")

  local output_path, output_file = Config:get_compiled_info(theme)
  Fs.ensure_dir(output_path)

  local file, err = io.open(output_file, "wb")
  if not file then
    require("borrowed.lib.log").error(fmt(
      [[Couldn't open %s: %s.

Check that %s is accessible for the current user.
You could try deleting %s to reset permissions]],
      output_file,
      err,
      output_file,
      output_path
    ))
    return
  end

  local compiled = loadstring(table.concat(lines, "\n"), "=")
  if compiled then
    file:write(compiled())
    file:close()
  else
    local tmpfile = Fs.join_paths(Fs.get_tmp_dir(), "borrowed.nvim_error.lua")
    require("borrowed.lib.log").error(fmt(
      [[There is an error in your borrowed.nvim config.
You can open '%s' for debugging.

If you think this is a bug, kindly open an issue and attach '%s' file.
Bellow is the error message:
]],
      tmpfile,
      tmpfile
    ))
    local efile = io.open(tmpfile, "wb")
    if efile then
      efile:write(table.concat(lines, "\n"))
      efile:close()
    else
      require("borrowed.lib.log").error("failed to create a debugging file")
    end
  end
end

return M
