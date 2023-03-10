local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "json", "yaml", "javascript" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- Python
  b.formatting.black,
  b.formatting.isort,
  b.diagnostics.mypy,

  -- Rust
  b.formatting.rustfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
