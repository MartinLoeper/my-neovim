{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-web-devicons;
  config = ''
    require'nvim-web-devicons'.setup()
  '';
  type = "lua";
}
