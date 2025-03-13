{ lua, fetchFromGitHub, neovimUtils }:
let
  beacon = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "beacon";
    version = "2.0.0";
    src = fetchFromGitHub {
      owner = "DanilaMihailov";
      repo = "beacon.nvim";
      rev = "098ff96c33874339d5e61656f3050dbd587d6bd5";
      hash = "sha256-0di4z5xkdyaqpmaa1iwirys91ikjm05g3pxr6sn3zh9h36czvzn7";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/DanilaMihailov/beacon.nvim";
      description =
        "Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is";
      license.fullName = "MIT";
    };
  }));
in (neovimUtils.buildNeovimPlugin { luaAttr = beacon; })

