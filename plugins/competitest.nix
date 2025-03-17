{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.competitest-nvim;
  config = ''
    require("competitest").setup();
  '';
  type = "lua";
}
