{ lua, fetchFromGitHub, neovimUtils }:
let
  direnv = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "direnv";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "NotAShelf";
      repo = "direnv.nvim";
      rev = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
      hash = "sha256-x/79mRkwwT+sNrnf8QqocsaQtM+Rx6BevVj5Nnv5JDY=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/NotAShelf/direnv.nvim";
      description =
        "Lua implementation of direnv.vim for automatic .envrc handling & syntax.";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = direnv; });
in {
  inherit plugin;
  config = ''
    require("direnv").setup({
       -- autoload_direnv = true,
    })
  '';
  type = "lua";
}

