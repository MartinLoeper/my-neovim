{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.surround-nvim;
  config = ''require("nvim-surround").setup()'';
  type = "lua";
}
