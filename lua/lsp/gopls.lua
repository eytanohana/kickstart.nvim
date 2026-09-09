-- gopls LSP config for Neovim 0.11+ native vim.lsp.config.
-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
--
-- gopls is installed with `go install golang.org/x/tools/gopls@latest` rather than
-- Mason: it has to be built by a toolchain compatible with the Go version in use,
-- and a Mason copy would shadow it on PATH while lagging behind the active toolchain.
-- Import organizing/formatting is delegated to goimports via Conform (see
-- lua/plugins/formatting.lua), so gopls formatting is not used on save.
local capabilities = require('blink.cmp').get_lsp_capabilities()
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  capabilities = capabilities,
  settings = {
    gopls = {
      -- staticcheck's analyzers on top of the default vet suite. This is the same
      -- family of checks golangci-lint runs in CI, so problems surface while typing.
      staticcheck = true,
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        nilness = true,
        useany = true,
        unusedvariable = true,
      },
      -- gofumpt is stricter than gofmt; the repo's golangci-lint config enables only
      -- the gofmt formatter, so keep gofumpt off to avoid fighting CI.
      gofumpt = false,
      usePlaceholders = true,
      completeUnimported = true,
      semanticTokens = true,
      -- Inlay hints are off until toggled with <leader>th (see lua/plugins/lsp.lua);
      -- gopls only emits them when the hint kinds are listed here.
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      -- Code lenses: `run test`, `go mod tidy`, dependency upgrades, `go generate`.
      codelenses = {
        generate = true,
        gc_details = false,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        regenerate_cgo = false,
        vendor = false,
      },
      -- Keep gopls out of vendored/build output trees.
      directoryFilters = { '-.git', '-node_modules', '-vendor', '-.venv', '-bin' },
    },
  },
}
