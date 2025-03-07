{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.render-markdown-nvim;
  config = ''
    require('render-markdown').setup({})
  '';
  type = "lua";
}
