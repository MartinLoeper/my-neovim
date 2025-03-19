{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.undotree;
  config = ''
    vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle)
  '';
  type = "lua";
}
