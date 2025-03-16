{ lua, fetchFromGitHub, neovimUtils }:
let
  workspaces = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "workspaces";
    version = "2.0.0";
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
    require("workspaces").setup()
    vim.keymap.set('n', '<leader>fp', '<cmd>Telescope workspaces<CR>', { desc = '[F]ind [P]rojects using Telescope' })
  '';
  type = "lua";
}

