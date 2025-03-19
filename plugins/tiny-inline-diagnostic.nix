{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
  config = ''
    require("tiny-inline-diagnostic").setup({
      preset = "powerline",
      show_diagnostic_on_hover = false,  -- Don't wait for hover
      diagnostic_delay = 0               -- No delay in showing diagnostics
    })

    vim.diagnostic.config({
      virtual_text = false,  -- Disable default virtual text
      underline = true,      -- Keep underlines
      signs = true           -- Keep signs in the gutter
    })
  '';
  type = "lua";
}

