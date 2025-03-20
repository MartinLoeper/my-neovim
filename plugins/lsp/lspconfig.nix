{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-lspconfig;
  config = ''
    local nvim_lsp = require('lspconfig')
    local fidget = require("fidget")

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local servers = { 'terraformls', 'gopls', 'hyprls', 'nil_ls', 'jsonls', 'marksman', 'ts_ls' }

    for _, lsp in ipairs(servers) do
      local config = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          fidget.notify(client.name .. " attached")
        end,
      }

      -- Add TypeScript-specific settings
      if lsp == 'ts_ls' then
        config.settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          }
        }
      end

      nvim_lsp[lsp].setup(config)
    end

    nvim_lsp.java_language_server.setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        fidget.notify(client.name .. " attached")
      end,
      cmd = { "java-language-server", "--stdio" },

      -- we use this little workaround for leetcode to work; otherwise the lsp refuses to spin up
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

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end,
    })
  '';
  type = "lua";
}
