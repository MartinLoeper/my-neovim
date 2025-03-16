{ lua, fetchFromGitHub, neovimUtils }:
let
  workspaces = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "workspaces";
    version = "2.0.0";
    src = fetchFromGitHub {
      owner = "natecraddock";
      repo = "workspaces.nvim";
      rev = "55a1eb6f5b72e07ee8333898254e113e927180ca";
      hash = "sha256-x/79mRkwwT+sNrnf8QqocsaQtM+Rx6BdvVj5Nnv5JDY=";
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
  '';
  type = "lua";
}

