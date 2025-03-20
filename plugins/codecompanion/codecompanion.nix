{ pkgs, ... }: {
  # WARN: we always want to be on the latest version because this s*t's lit
  plugin = (pkgs.vimPlugins.codecompanion-nvim.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "olimorris";
      repo = "codecompanion.nvim";
      rev = "95680637c4e1605826544a96478e26bc96687ad2";
      sha256 = "sha256-LKC0y6/+6PWlIIWpfBdfaTFVnndFvk7id2kBMwrIlKQ=";
    };
  }));
  config = pkgs.lib.strings.concatStrings [
    (builtins.readFile ./codecompanion.lua)
    (builtins.readFile ./codecompanion-fidget.lua)
  ];
  type = "lua";
}
