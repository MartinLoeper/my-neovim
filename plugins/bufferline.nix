{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.bufferline-nvim;
  config = ''
    vim.opt.termguicolors = true
    require("bufferline").setup{
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
      options = {
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = false,
        offsets = {
          {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true -- use a "true" to enable the default, or set your own character
          }
        }
      }
    }
  '';
  type = "lua";
}
