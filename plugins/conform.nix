{ pkgs, ... }: {
  # note: use gq{motion} to format buffer content -> sometimes not working...
  # saving always works if the formatter is set below...
  plugin = pkgs.vimPlugins.conform-nvim;
  config = ''
    require("conform").setup({
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        nix = { "nixfmt" },
        java = { "google-java-format", lsp_format = "never" }
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  '';
  type = "lua";
}
