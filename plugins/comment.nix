{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-comment;
  config = ''
    require('Comment').setup()
  '';
  type = "lua";
}
