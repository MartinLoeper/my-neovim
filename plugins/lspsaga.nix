{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.lspsaga-nvim;
  config = ''
    require('lspsaga').setup({
      lightbulb = {
        enable = false, -- Disable the light bulb feature
      },
    })
  '';
  type = "lua";
}
