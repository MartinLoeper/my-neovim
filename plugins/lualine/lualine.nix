{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.lualine-nvim;
  config = ''
    require('lualine').setup {
      sections = {
        lualine_f = { 'filename' },
        lualine_p = {
          'lsp_progress'
        },
        lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' },
      },
      extensions = {
        {
          filetypes = { "codecompanion" },
          sections = {
            lualine_a = {
            },
            lualine_b = {
              require('lualine-codecompanion')
            },
            lualine_c = {
            },
            lualine_x = {},
            lualine_y = {
              "progress",
            },
            lualine_z = {
              "location",
            },
          },
        },
      },
    }
  '';
  type = "lua";
}
