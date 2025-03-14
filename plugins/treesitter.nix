{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  config = ''
    require'nvim-treesitter.configs'.setup {
      sync_install = false,
      auto_install = false,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
    }

    vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
    })
  '';
  type = "lua";
}
