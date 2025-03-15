{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.lualine-nvim;
  config = ''
    local codecompanion = require('lualine-codecompanion')

    require('lualine').setup {
      sections = {
        lualine_f = { 'filename' },
        lualine_p = {
          'lsp_progress'
        },
        lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' },
      },
    }
  '';
  type = "lua";
}
