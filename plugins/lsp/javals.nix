{ pkgs, ... }: {
  home.packages = [ pkgs.java-language-server pkgs.google-java-format ];
}
