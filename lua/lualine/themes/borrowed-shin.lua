local lualine = require("lualine")

local _, pal, _ = require("borrowed.themes"):get("shin")
-- stylua: ignore
local colors = {
  bg     = pal.sheet,
  fg     = pal.plain,
  orange = pal.speak,
  blue   = pal.extra,
  red    = pal.yell,
  pink   = pal.whisper,
  brown  = pal.shy,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    component_separators = "",
    section_separators = "",
    globalstatus = true,
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- Left side
ins_left({
  function()
    return "▊"
  end,
  color = { fg = colors.red },
  padding = { left = 0, right = 1 },
})

ins_left({
  function()
    return ""
  end,
  color = function()
    local mode_color = {
      n = colors.red,
      i = colors.fg,
      v = colors.orange,
      [""] = colors.orange,
      V = colors.orange,
      c = colors.blue,
      no = colors.blue,
      s = colors.pink,
      S = colors.pink,
      [""] = colors.orange,
      ic = colors.orange,
      R = colors.pink,
      Rv = colors.pink,
      cv = colors.blue,
      ce = colors.blue,
      r = colors.blue,
      rm = colors.blue,
      ["r?"] = colors.blue,
      ["!"] = colors.blue,
      t = colors.blue,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
})

ins_left({
  function()
    return vim.api.nvim_buf_line_count(0)
  end,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.fg, gui = "bold" },
})

ins_left({
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
    return { fg = colors.red, gui = "bold" }
  end,
})

ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = function()
    if require("grapple").exists() == true then
      return { fg = colors.red, gui = "bold,underline" }
    end
    return { fg = colors.red, gui = "bold" }
  end,
})

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", hint = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.orange },
    color_hint = { fg = colors.blue },
    color_info = { fg = colors.brown },
  },
})

ins_left({
  function()
    return "%="
  end,
})

-- Right side
ins_right({
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  diff_color = {
    added = { fg = colors.blue },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

vim.g.root_indicator = ".git"
vim.g.root_cache = {}
ins_right({
  function()
    local filePath = vim.api.nvim_buf_get_name(0)

    -- if no buffer is open
    if filePath == "" then
      if vim.g.project_name == nil then
        local root = vim.fn.getcwd()
        vim.g.project_name = vim.fn.substitute(root, "^.*/", "", "")
      end
      return vim.g.project_name
    end

    local dirPath = vim.fs.dirname(filePath)
    local root = vim.g.root_cache[dirPath]
    if root == nil then
      local root_file = vim.fs.find(vim.g.root_indicator, { path = dirPath, upward = true })[1]
      if root_file == nil then
        if vim.g.project_name ~= nil then
          return vim.g.project_name
        end
        -- if there is no git repo initialized, display dir of the open buf
        root_file = filePath
      end

      root = vim.fs.dirname(root_file)
      if root == "." then
        vim.g.root_cache[dirPath] = vim.g.project_name
        return vim.g.project_name
      end

      vim.g.project_name = vim.fn.substitute(root, "^.*/", "", "")
      vim.g.root_cache[dirPath] = vim.g.project_name
    end

    return vim.g.project_name
  end,

  icon = "󰛓",
  color = { fg = colors.red, gui = "bold" },
})

ins_right({
  function()
    local handle = io.popen("git branch --show-current 2>/dev/null")
    local result = handle:read("*a")
    handle:close()

    local branchName = string.gsub(result, "\n", "")
    local startPos, endPos = string.find(branchName, "/")
    if startPos then
      branchName = string.sub(branchName, endPos + 1)
    end

    return branchName
  end,
  icon = "",
  color = { fg = colors.red, gui = "bold" },
})

ins_right({
  function()
    return "▊"
  end,
  color = { fg = colors.red },
  padding = { left = 1 },
})

lualine.setup(config)
