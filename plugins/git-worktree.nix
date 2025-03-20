{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.git-worktree-nvim;
  config = ''
    require("git-worktree").setup({
  '';
  type = "lua";
}
