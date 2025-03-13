{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.ultimate-autopair-nvim;
  config = ''
    require("ultimate-autopair").setup({
      tabout = {
        enable = true;
        hopout = true;
      },
      fastwarp = {
        enable = true;
        map = "<C-i>";
      },
    })
  '';
  type = "lua";
}

