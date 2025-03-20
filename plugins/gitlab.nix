{ pkgs, lua, fetchFromGitHub, neovimUtils }:
let
  gitlab = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "gitlab";
    version = "3.3.12";
    src = fetchFromGitHub {
      owner = "harrisoncramer";
      repo = "gitlab.nvim";
      rev = "9f898aa1a8cd74fc11756c295a56ea0d4952cf40";
      hash = "sha256-V1v9+KVVL2jDWCfMx/M7ePIo0W6tRLwM63VyfxrPLac=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    buildInputs = [ pkgs.go pkgs.util-linux ];

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/harrisoncramer/gitlab.nvim";
      description = " Manage Gitlab resources in Neovim";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = gitlab; });
in {
  inherit plugin;
  config = ''
    require('gitlab').setup({ })
  '';
  type = "lua";
}

