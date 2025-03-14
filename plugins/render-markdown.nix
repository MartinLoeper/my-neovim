{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.render-markdown-nvim;
  config = ''
    require('render-markdown').setup({
      ft = { "markdown", "codecompanion" }
    })
  '';
  type = "lua";
}
