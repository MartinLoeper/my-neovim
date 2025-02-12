{ lua, fetchFromGitHub, neovimUtils }:
let
  monaspace-lua = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "monaspace-lua";
    version = "0.0.1";
    src = fetchFromGitHub {
      owner = "jackplus-xyz";
      repo = "monaspace.nvim";
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
      homepage = "https://github.com/jackplus-xyz/monaspace.nvim";
      description =
        "A Neovim plugin that allows users to try mix and match Monaspace fonts";
      license.fullName = "MIT";
    };
  }));
in (neovimUtils.buildNeovimPlugin { luaAttr = monaspace-lua; })

