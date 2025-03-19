{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.tabout-nvim;
  config = ''
    require("tabout").setup()
  '';
  type = "lua";
}
