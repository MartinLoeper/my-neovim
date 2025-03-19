{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.telescope-undo-nvim;
  config = ''
    vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
  '';
  type = "lua";
}
