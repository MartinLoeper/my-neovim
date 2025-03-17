{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.telescope-lsp-handlers-nvim;
  config = ''
    require('telescope').load_extension('lsp_handlers')

    vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
  '';
  type = "lua";
}
