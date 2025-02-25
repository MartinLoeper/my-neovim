{ lua, fetchFromGitHub, neovimUtils }:
let
  neominimap = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "neominimap";
    version = "3.9.1";
    src = fetchFromGitHub {
      owner = "lsrothy";
      repo = "neominimap";
      rev = "8f6e5e64393b530fd1d8e0ea96c51ffbb4046186";
      hash = "sha256-udElc6B8uK8YKg54srBHvdZCNH80rsB5VdPTyoWchSE=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/Isrothy/neominimap.nvim";
      description = "Yet another minimap plugin for Neovim";
      license.fullName = "MIT";
    };
  }));
in (neovimUtils.buildNeovimPlugin { luaAttr = neominimap; })
