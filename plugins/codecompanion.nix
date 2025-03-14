{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = builtins.readFile ./codecompanion.lua;
  type = "lua";
}
