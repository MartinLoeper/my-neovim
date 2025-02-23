{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-comment;
  config = ''
    require('nvim_comment').setup()
  '';
  type = "lua";
}
