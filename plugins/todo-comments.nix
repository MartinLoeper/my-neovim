{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.todo-comments-nvim;
  config = ''
    require("todo-comments").setup {}
  '';
  type = "lua";
}
