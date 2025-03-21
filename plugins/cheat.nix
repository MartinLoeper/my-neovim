{ lua, fetchFromGitHub, neovimUtils }:
let
  cheat = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "cheat";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "siawkz";
      repo = "nvim-cheatsh";
      rev = "f35915775bf6e1a7b61b292b2bf713c7be82ae69";
      hash = "sha256-HI/ZdsaqdEIiOvPnIZJjXe8CWAn/u5A029IScySLxBs=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    doCheck = false;

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
      cp -r plugin/. $out/plugin/
    '';

    meta = {
      homepage = "https://github.com/RishabhRD/nvim-cheat.sh";
      description =
        "Seamless integration of cheat.sh with Neovim: Access a wide range of cheat sheets directly through Telescope.";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin {
    luaAttr = cheat;
    config = ''
      require("nvim-cheatsh").setup({
        position = "right"
      })
    '';
    type = "lua";
  });
in { inherit plugin; }

