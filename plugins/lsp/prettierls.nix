{ pkgs, ... }: {
  home.packages =
    [ pkgs.prettierd pkgs.nodePackages_latest.prettier pkgs.eslint ];
}
