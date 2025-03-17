{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.neogit;
  config = ''
    require('neogit').setup {}
  '';
  type = "lua";
}
