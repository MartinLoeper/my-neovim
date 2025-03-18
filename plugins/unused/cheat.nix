{ lua, fetchFromGitHub, neovimUtils }:
let
  cheat = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "beacon";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "RishabhRD";
      repo = "nvim-cheat.sh";
      rev = "eb6acbacd39cf7c1966cb58d6586351db14607da";
      hash = "sha256-N3/kMDA9nscg3R9qvaVVUnrvOs9PehZWjyefEzEMiME=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/RishabhRD/nvim-cheat.sh";
      description = "cheat.sh integration for neovim in elegant way";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = cheat; });
in { inherit plugin; }

