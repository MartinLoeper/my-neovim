{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.zellij-nav-nvim;
  config = ''
    require("zellij-nav").setup()

    vim.keymap.set("n", "<c-left>", "<cmd>ZellijNavigateLeftTab<cr>",  { desc = "navigate left or tab"  })
    vim.keymap.set("n", "<c-down>", "<cmd>ZellijNavigateDown<cr>",  { desc = "navigate down" })
    vim.keymap.set("n", "<c-up>", "<cmd>ZellijNavigateUp<cr>",    { desc = "navigate up" })
    vim.keymap.set("n", "<c-right>", "<cmd>ZellijNavigateRightTab<cr>", { desc = "navigate right or tab" })
  '';
  type = "lua";
}
