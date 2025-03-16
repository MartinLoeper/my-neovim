{ lua, fetchFromGitHub, neovimUtils }:
let
  sessions = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "sessions";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "natecraddock";
      repo = "sessions.nvim";
      rev = "f13158483e0b6255c6dfe473145ce4ee3495d844";
      hash = "sha256-Wb43+v9l3XVLlroTHq/9ruJzuK/dNAsqNCL9kpLhFEk";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
    '';

    meta = {
      homepage = "https://github.com/natecraddock/sessions.nvim";
      description = "a simple session manager plugin";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = sessions; });
in {
  inherit plugin;
  config = ''
    require("sessions").setup({
      events = { "WinEnter" },
      session_filepath = vim.fn.stdpath("data") .. "/sessions",
      absolute = true,
    })
  '';
  type = "lua";
}

