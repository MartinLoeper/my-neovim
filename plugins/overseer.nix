{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.overseer-nvim;
  config = ''
    require('overseer').setup({
      strategy = {
        "toggleterm",
        use_shell = true
      }
    })

    vim.cmd([[cab or OverseerRun]])
  '';
  type = "lua";
}
