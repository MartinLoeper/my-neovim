{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.fidget-nvim;
  config = ''
    require("fidget").setup {
      notification = {
        window = {
          winblend = 0,
        },
      }
    }
  '';
  type = "lua";
}
