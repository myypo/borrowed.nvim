-- https://neovim.io/doc/user/lsp.html#lsp-semantic-highlight

local M = {}

---@param pal ThemePalette
---@param spec ThemeSpec
---@param mod ModuleConfig
---@return Module
function M.get(pal, spec, mod)
  ---@type Module
  local res = {}

  --- Definitions for all languages ---
  res["@lsp.type.boolean"] = { link = "@boolean" }
  res["@lsp.type.builtinType"] = { link = "@type.builtin" }
  res["@lsp.type.comment"] = {} -- use treesitter styles because some languages break special comment styling
  res["@lsp.type.enum"] = { link = "@type" }
  res["@lsp.type.enumMember"] = { link = "@constant" }
  res["@lsp.type.escapeSequence"] = { link = "@string.escape" }
  res["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" }
  res["@lsp.type.interface"] = { link = "@type" }
  res["@lsp.type.keyword"] = { link = "@keyword" }
  res["@lsp.type.namespace"] = { link = "@module" }
  res["@lsp.type.number"] = { link = "@number" }
  res["@lsp.type.operator"] = {} -- color word operators (or/and) the same way as keywords
  res["@lsp.type.parameter"] = { link = "@parameter" }
  res["@lsp.type.property"] = { link = "@property" }
  res["@lsp.type.selfKeyword"] = { link = "@variable.builtin" }
  res["@lsp.type.typeAlias"] = { link = "@type.definition" }
  res["@lsp.type.unresolvedReference"] = { link = "@error" }
  res["@lsp.type.variable"] = { link = "@variable" }
  res["@lsp.type.decorator"] = { link = "@macro" }

  res["@lsp.type.function"] = {} -- color functions depending on the context, sometimes they act as variables etc.
  res["@lsp.typemod.function"] = {}
  res["@lsp.typemod.function.constant"] = { link = "@function" }

  res["@lsp.mod.builtin"] = { link = "@constant.builtin" }
  res["@lsp.mod.constant"] = { link = "@constant" }
  res["@lsp.mod.readonly"] = { link = "@constant" }

  res["@lsp.typemod.keyword"] = { link = "@keyword" }
  res["@lsp.typemod.operator.injected"] = { link = "@operator" }

  res["@lsp.typemod.string.injected"] = { link = "@string" }
  res["@lsp.typemod.function.injected"] = { link = "@function" }
  res["@lsp.typemod.type.defaultLibrary"] = { link = "@type.builtin" }
  res["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" }
  res["@lsp.typemod.variable.injected"] = { link = "@variable" }
  res["@lsp.typemod.property.declaration"] = { link = "@variable" }
  res["@lsp.typemod.unresolvedReference.injected"] = { link = "@variable" }

  --- Rust ---
  res["@lsp.type.lifetime.rust"] = { link = "@operator" }

  -- Trick to color exclamation mark differently than the rest of the macro call
  res["@lsp.type.macro.rust"] = { link = "@function.builtin" }
  res["@lsp.typemod.macro.library.rust"] = { link = "@macro" }

  res["@lsp.type.deriveHelper.rust"] = { link = "@macro" }

  --- Nix ---
  res["@lsp.typemod.function.builtin.nix"] = { link = "@function" }

  --- Go ---
  res["@variable.member.go"] = { link = "@variable" }
  res["@lsp.type.variable.go"] = {}

  --- TS/JS ---
  res["@lsp.mod.readonly.typescript"] = {}
  res["@lsp.mod.readonly.javascript"] = {}

  return res
end

return M
