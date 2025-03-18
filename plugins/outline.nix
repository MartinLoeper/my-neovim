{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.outline-nvim;
  config = ''
    require("outline").setup({})

    vim.keymap.set('n', '<leader>n', '<cmd>Outline<CR>', { noremap = true, silent = true })
  '';
  type = "lua";
}
