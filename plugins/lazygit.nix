{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.lazygit-nvim;
  config = ''
    vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>LazyGit<cr>', { noremap = true, silent = true })
  '';
  type = "lua";
}
