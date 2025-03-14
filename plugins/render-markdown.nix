{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.render-markdown-nvim;
  config = ''
    require('render-markdown').setup({
      file_types = { "markdown", "codecompanion" }
    })
  '';
  type = "lua";
}
