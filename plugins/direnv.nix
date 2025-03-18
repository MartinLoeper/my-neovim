{ lua, fetchFromGitHub, neovimUtils }:
let
  direnv = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "direnv";
    version = "1.0.0";
    src = fetchFromGitHub {
      owner = "MartinLoeper";
      repo = "direnv.nvim";
      rev = "3946f13d145ca35d8ea1fbb0242c628120ede075";
      hash = "sha256-qLlxyp5KmSGfWn4Vz5jyNC9s7UKYoQ3d5JnZFP0J1xI=";
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
    local direnv = require("direnv")
    direnv.setup()

    -- Create an autocmd to reload direnv when directory changes
    vim.api.nvim_create_autocmd("DirChanged", {
      pattern = "*",
      callback = function()
        direnv.check_direnv()
      end
    })
  '';
  type = "lua";
}

