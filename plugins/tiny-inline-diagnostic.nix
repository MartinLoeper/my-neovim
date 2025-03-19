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
      diagnostic_delay = 0               -- No delay in showing diagnostics
    })

    vim.diagnostic.config({
      virtual_text = false,  -- Disable default virtual text
      underline = true,      -- Keep underlines
      signs = {
        linehl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLn",
          [vim.diagnostic.severity.WARN]  = "DiagnosticWarnLn",
          [vim.diagnostic.severity.INFO]  = "DiagnosticInfoLn",
          [vim.diagnostic.severity.HINT]  = "DiagnosticHintLn",
        },
      }
    })
  '';
  type = "lua";
}

