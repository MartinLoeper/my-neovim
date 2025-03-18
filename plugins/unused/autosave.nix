{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.autosave-nvim;
  config = ''
    require("autosave").setup {
      events = {
        register = true, -- Should autosave register its autocommands
        triggers = { -- The autocommands to register, if enabled
          'BufLeave',
        }
      },
    }
  '';
  type = "lua";
}
