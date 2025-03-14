{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = pkgs.lib.strings.concatStrings [
    (builtins.readFile ./codecompanion.lua)
    (builtins.readFile ./codecompanion-fidget.lua)
  ];
  type = "lua";
}
