{ lua, fetchFromGitHub, neovimUtils }:
let
  lualine-codecompanion = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "lualine-codecompanion";
    version = "1.0.0";
    src = ./lualine-codecompanion.lua;
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r $src $out/lua/lualine-codecompanion.lua
    '';

    dontUnpack = true;

    meta = {
      homepage =
        "https://codecompanion.olimorris.dev/usage/ui.html#user-interface";
      description = "Module to display info about codecompanion in lualine";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = lualine-codecompanion; });
in { inherit plugin; }

