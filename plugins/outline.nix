{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.outline-nvim;
  config = ''
    require("outline").setup({
      outline_window = {
        auto_jump = true,
        wrap = true,
      }
    })

    vim.keymap.set('n', '<leader>n', '<cmd>Outline<CR>', { noremap = true, silent = true })
  '';
  type = "lua";
}
