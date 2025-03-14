{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = builtins.readFile ./codecompanion.lua + "\n"
    + builtins.readFile ./codecompanion-fidget.lua;
  type = "lua";
}
