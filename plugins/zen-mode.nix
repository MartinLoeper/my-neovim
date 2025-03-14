{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.zen-mode-nvim;
  config = ''
    require("zen-mode").setup {
      plugins = {
        twilight = { enabled = true },
        wezterm = { enabled = true, font = "+5", }
      }
    }

    vim.api.nvim_set_keymap("n", "<leader>z", ":ZenMode<CR>", {})
  '';
  type = "lua";
}
