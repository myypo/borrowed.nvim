if vim.g.loaded_borrowed then
  return
end

vim.api.nvim_create_user_command(
  "BorrowedCompile",
  require("borrowed").compile_plugin,
  { desc = "Recompile borrowed.nvim colorscheme plugin" }
)

vim.g.loaded_borrowed = 1
