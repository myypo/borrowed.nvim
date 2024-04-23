local Modules = require("lualine.themes.borrowed.modules")

local M = {}

---@param hl_name string
---@param field_name string
---@return string
local function get_hl_color(hl_name, field_name)
  return string.format("%06x", vim.api.nvim_get_hl(0, { name = hl_name, link = false })[field_name])
end

function M.setup()
  ---@class  LualineColors
  local colors = {
    bg = get_hl_color("StatusLine", "bg"),
    fg = get_hl_color("Normal", "fg"),
    decor = get_hl_color("FloatBorder", "fg"),
    added = get_hl_color("diffAdded", "fg"),
    changed = get_hl_color("diffChanged", "fg"),
    removed = get_hl_color("diffRemoved", "fg"),
    visual = get_hl_color("Visual", "bg"),
    hint = get_hl_color("DiagnosticHint", "fg"),
    info = get_hl_color("DiagnosticInfo", "fg"),
  }

  local Lualine = require("lualine")

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

  ---@param component table?
  local function ins_left(component)
    if not component then
      return
    end
    table.insert(config.sections.lualine_c, component)
  end
  ---@param component table?
  local function ins_right(component)
    if not component then
      return
    end
    table.insert(config.sections.lualine_x, component)
  end

  ins_left({
    function()
      return "▊"
    end,
    color = { fg = colors.decor },
    padding = { left = 0, right = 1 },
  })

  ins_left({
    function()
      return ""
    end,
    color = function()
      local mode_color = {
        n = colors.decor,
        i = colors.fg,
        v = colors.visual,
        [""] = colors.visual,
        V = colors.visual,
        c = colors.hint,
        no = colors.hint,
        s = colors.removed,
        S = colors.removed,
        [""] = colors.changed,
        ic = colors.changed,
        R = colors.removed,
        Rv = colors.removed,
        cv = colors.hint,
        ce = colors.hint,
        r = colors.hint,
        rm = colors.hint,
        ["r?"] = colors.hint,
        ["!"] = colors.hint,
        t = colors.hint,
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

  ins_left(Modules.oil_curr_dir(colors.decor))

  ins_left(Modules.filename(colors.decor))

  ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

  ins_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", hint = " ", info = " " },
    diagnostics_color = {
      color_error = { fg = colors.removed },
      color_warn = { fg = colors.changed },
      color_hint = { fg = colors.hint },
      color_info = { fg = colors.info },
    },
  })

  ins_left({
    function()
      return "%="
    end,
  })

  ins_right({
    "diff",
    symbols = { added = " ", modified = "󰝤 ", removed = " " },
    diff_color = {
      added = { fg = colors.added },
      modified = { fg = colors.changed },
      removed = { fg = colors.removed },
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
    color = { fg = colors.decor, gui = "bold" },
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
    color = { fg = colors.decor, gui = "bold" },
  })

  ins_right({
    function()
      return "▊"
    end,
    color = { fg = colors.decor },
    padding = { left = 1 },
  })

  Lualine.setup(config)
end

return M
