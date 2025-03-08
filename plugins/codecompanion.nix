{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.codecompanion-nvim;
  config = ''
    require("codecompanion").setup()
  '';
  type = "lua";
}
