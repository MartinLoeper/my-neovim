{ lua, fetchFromGitHub, neovimUtils }:
let
  typr-lua = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "typr-lua";
    version = "0.0.1";
    srcs = [
      (fetchFromGitHub {
        owner = "nvzone";
        repo = "typr";
        name = "typr";
        rev = "727d830184777d0ea1dba8508bc0b95f0ae356a9";
        hash = "sha256-5KSYqUghG5dqY5U0eL3AZ+lGopMHqgdgnpVU1dO/IS4=";
      })
      (fetchFromGitHub {
        owner = "nvzone";
        repo = "volt";
        name = "volt";
        rev = "1a7d6b1dfb2f176715ccc9e838be32d044f8a734";
        hash = "sha256-4KFGlFcaV+X98gK+VeR0spceDpy108wk19LYd/oUXc0=";
      })
    ];
    sourceRoot = ".";
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r typr/lua/. $out/lua/
      cp -r volt/lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/nvzone/typr";
      description = "Typing practice plugin with good ui! for Neovim (WIP)";
      license.fullName = "GPL-3.0";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = typr-lua; });
in {
  inherit plugin;
  config = ''
    require('typr').setup()
  '';
  type = "lua";
}

