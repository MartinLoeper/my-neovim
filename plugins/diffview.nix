{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.diffview-nvim;
  config = ''
    require("diffview").setup()
  '';
  type = "lua";
}

