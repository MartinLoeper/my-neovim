{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = ''
    local nvim_lsp = require('lspconfig')
    local fidget = require("fidget")

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local servers = { 'terraformls', 'gopls', 'hyprls', 'nil_ls', 'jsonls', 'marksman' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          fidget.notify(client.name .. " attached")
        end,
      }
    end

      nvim_lsp.java_language_server.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          fidget.notify(client.name .. " attached")
        end,
        cmd = { "java-language-server", "--stdio" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            "pom.xml",
            "build.gradle",
            "build.gradle.kts",
            ".git"
          )(fname) or require("lspconfig.util").path.dirname(fname)
        end,
      }

    -- configure lua separately to include the neovim lua runtime, see lspconfig docs
    nvim_lsp.lua_ls.setup {
      capabilities = capabilities,
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }
  '';
  type = "lua";
}
