{ pkgs, ... }: {
  # WARN: primagen apparently abandoned his plugin, so we use a fork
  plugin = (pkgs.vimPlugins.git-worktree-nvim.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "polarmutex";
      repo = "git-worktree.nvim";
      rev = "3ad8c17a3d178ac19be925284389c14114638ebb";
      sha256 = "sha256-LKC0y6/+6PWlIIWpfBdfaTFVnndFve7id2kBMwrIlKQ=";
    };
  }));
  config = ''
    require("git-worktree").setup()
  '';
  type = "lua";
}
