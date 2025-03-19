{ pkgs, ... }: {
  plugin = pkgs.telescope-undo-nvim;
  config = ''
    vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
  '';
  type = "lua";
}
