{ lua, fetchFromGitHub, neovimUtils }:
let
  workspaces = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "workspaces";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "natecraddock";
      repo = "workspaces.nvim";
      rev = "55a1eb6f5b72e07ee8333898254e113e927180ca";
      hash = "sha256-a3f0NUYooMxrZEqLer+Duv6/ktq5MH2qUoFHD8z7fZA=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/natecraddock/workspaces.nvim.git";
      description = "a simple plugin to manage workspace directories in neovim";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = workspaces; });
in {
  inherit plugin;
  config = ''
    require("workspaces").setup({
     hooks = {
        -- hooks run before change directory
        open_pre = {
          -- If recording, save current session state and stop recording
          "SessionsStop",

          -- delete all buffers (does not save changes)
          "silent %bdelete!",
        },

        -- hooks run after change directory
        open = {
            -- load any saved session from current directory
            function()
              local success = require("sessions").load(nil, { silent = true })
              vim.cmd('NvimTreeOpen')

              if not success then
                require('telescope.builtin').find_files({
                    hidden = true,
                    selection_strategy = 'select_horizontal',
                    previewer = true
                })
              end
            end,
        }
      },
    })
    vim.keymap.set('n', '<leader>fp', '<cmd>Telescope workspaces<CR>', { desc = '[F]ind [P]rojects using Telescope' })

    -- see: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      pattern = 'NvimTree*',
      callback = function()
        local api = require('nvim-tree.api')
        local view = require('nvim-tree.view')

        if not view.is_visible() then
          api.tree.open()
        end
      end,
    })
  '';
  type = "lua";
}

