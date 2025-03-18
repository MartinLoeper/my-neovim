{ lua, fetchFromGitHub, neovimUtils }:
let
  cheat = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "cheat";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "siawkz";
      repo = "nvim-cheatsh";
      rev = "f35915775bf6e1a7b61b292b2bf713c7be82ae69";
      hash = "sha256-N3/kMDAdnscg3R9qvaVVUnrvOs9PehZWjyefEzEMiME=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/RishabhRD/nvim-cheat.sh";
      description =
        "Seamless integration of cheat.sh with Neovim: Access a wide range of cheat sheets directly through Telescope.";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = cheat; });
in { inherit plugin; }

