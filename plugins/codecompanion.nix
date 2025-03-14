{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = builtins.concatStrings [
    (builtins.readFile ./codecompanion.lua)
    (builtins.readFile ./codecompanion-fidget.lua)
  ];
  type = "lua";
}
