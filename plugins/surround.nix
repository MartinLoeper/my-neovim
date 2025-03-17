{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-surround;
  config = ''require("nvim-surround").setup()'';
  type = "lua";
}
