{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.unimpaired-nvim;
  config = ''
    require('unimpaired').setup {}
  '';
  type = "lua";
}
