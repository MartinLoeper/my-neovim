{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.efmls-configs-nvim;
  config = ''
    -- Register linters and formatters per language
    --local eslint = require('efmls-configs.linters.eslint')
    -- local prettier = require('efmls-configs.formatters.prettier')
    local eslint = {
      prefix = 'eslint',
      lintCommand = 'eslint --no-color --format visualstudio ''${INPUT}',
      lintStdin = true,
      lintIgnoreExitCode = true,
      lintFormats = { '%f(%l,%c): %trror %m', '%f(%l,%c): %tarning %m' },
      rootMarkers = { '.eslintrc.json' },
    }
    local prettier = {
      formatCommand = 'prettier --stdin --stdin-filename ''${INPUT}',
      formatStdin = true,
      rootMarkers = { '.prettierrc' },
    }

    local languages = {
      typescript = { eslint, prettier },
    }

    local efmls_config = {
      filetypes = vim.tbl_keys(languages),
      settings = {
        rootMarkers = { '.git/' },
        languages = languages,
      },
      init_options = {
        documentFormatting = false,
        documentRangeFormatting = false,
      },
      cmd = { 'efm-langserver', '-loglevel', '4' },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        fidget.notify(client.name .. " attached")
      end,
    }))
  '';
  type = "lua";
}
