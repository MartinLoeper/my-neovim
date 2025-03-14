{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.figet-nvim;
  config = ''
    require("fidget").setup {}
  '';
  type = "lua";
}
