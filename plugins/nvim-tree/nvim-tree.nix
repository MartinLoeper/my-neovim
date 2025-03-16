{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.nvim-tree-lua;
  config = pkgs.lib.strings.concatStrings [
    (builtins.readFile ./quickfix-decorator.lua)
    ''
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        update_focused_file = {
          enable = true,         -- Enable automatic focusing
          update_cwd = true,     -- Update the current working directory to match the file
          ignore_list = {}       -- Files to ignore
        },
        diagnostics = {
          enable = true,
        },
      })
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    ''
  ];
  type = "lua";
}
