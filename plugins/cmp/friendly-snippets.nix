{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.friendly-snippets;
  config = ''
    vim.tbl_map(
      function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
      { "vscode", "snipmate", "lua" }
    )
  '';
  type = "lua";
}
