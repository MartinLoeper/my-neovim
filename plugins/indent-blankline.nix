{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.indent-blankline-nvim;
  config = ''
    require("ibl").setup()
  '';
  type = "lua";
}
