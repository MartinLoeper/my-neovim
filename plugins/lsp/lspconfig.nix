{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = ''
    local nvim_lsp = require('lspconfig')

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    local navbuddy = require("nvim-navbuddy")

    local servers = { 'terraformls', 'gopls', 'hyprls', 'nil_ls', 'jsonls', 'lua_ls' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)                    
          navbuddy.attach(client, bufnr)
        end
      }
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  '';
  type = "lua";
}
