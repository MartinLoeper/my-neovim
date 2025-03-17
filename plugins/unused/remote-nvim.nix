{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.remote-nvim-nvim;
  config = ''
    require("remote-nvim").setup()
  '';
  type = "lua";
}
