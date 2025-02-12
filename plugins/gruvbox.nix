{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.gruvbox;
  config = ''
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd("colorscheme gruvbox")
  '';
  type = "lua";
}
