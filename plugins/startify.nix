{ pkgs, ... }:

{
  plugin = pkgs.vimPlugins.vim-startify;
  config = "let g:startify_change_to_vcs_root = 0";
}
