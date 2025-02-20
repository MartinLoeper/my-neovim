{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.leetcode-nvim;
  config = ''
    require('leetcode').setup()
  '';
  type = "lua";
}
