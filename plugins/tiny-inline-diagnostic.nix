{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
  config = ''
    require("tiny-inline-diagnostic").setup({
      preset = "powerline",
      show_source = true,
      set_arrow_to_diag_color = true,
      multiple_diag_under_cursor = true,
      multilines = {
          enabled = true,
          always_show = true,
      },
    })

    vim.diagnostic.config({
      virtual_text = false,  -- Disable default virtual text
      underline = true,      -- Keep underlines
      signs = {
        linehl = {
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
          [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
          [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
        },
      }
    })
  '';
  type = "lua";
}

