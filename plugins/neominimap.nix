{ lua, fetchFromGitHub, neovimUtils }:
let
  neominimap = lua.pkgs.toLuaModule (lua.stdenv.mkDerivation ({
    name = "neominimap";
    version = "3.9.1";
    src = fetchFromGitHub {
      owner = "Isrothy";
      repo = "neominimap.nvim";
      rev = "505e756fc96d05a7c372792fe76e346aa0ed9240";
      hash = "sha256-HQEgVk3xdIihg0kVV83PikOo008DblDhxGGswKryvMo=";
    };
    rockspecVersion = "1.1";
    rocksSubdir = "dummy";

    installPhase = ''
      mkdir -p $out/lua
      cp -r lua/. $out/lua/
      cp -r plugin/. $out/plugin/
    '';

    meta = {
      homepage = "https://github.com/Isrothy/neominimap.nvim";
      description = "Yet another minimap plugin for Neovim";
      license.fullName = "MIT";
    };
  }));
  plugin = (neovimUtils.buildNeovimPlugin { luaAttr = neominimap; });
in {
  inherit plugin;
  config = ''
    vim.g.neominimap = {
      auto_enable = false,
      layout = "float",
      click = {
        enabled = true
      },
      mark = {
        enabled = false
      }
    }
    vim.keymap.set('n', '<leader>tm', '<cmd>Neominimap toggle<cr>', { desc = 'Toggle minimap' })
  '';
  type = "lua";

}
