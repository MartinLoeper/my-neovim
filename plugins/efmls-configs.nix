{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.efmls-configs-nvim;
  config = ''
    -- Register linters and formatters per language
    local eslint = require('efmls-configs.linters.eslint')
    local prettier = require('efmls-configs.formatters.prettier')
    local stylua = require('efmls-configs.formatters.stylua')
    local languages = {
      typescript = { eslint, prettier },
    }

    local efmls_config = {
      filetypes = vim.tbl_keys(languages),
      settings = {
        rootMarkers = { '.git/', 'package.json' },
        languages = languages,
      },
      init_options = {
        documentFormatting = false,
        documentRangeFormatting = false,
      },
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
