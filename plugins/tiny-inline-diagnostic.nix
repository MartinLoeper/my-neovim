{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
  config = ''
    require("tiny-inline-diagnostic").setup({
      preset = "powerline"
    })

    vim.diagnostic.config({ virtual_text = false })
  '';
  type = "lua";
}
