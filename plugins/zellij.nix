{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.zellij-nav-nvim;
  config = ''
    require("zellij-nav").setup()

    vim.keymap.set("n", "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { desc = "navigate left or tab"  })
    vim.keymap.set("n", "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { desc = "navigate down" })
    vim.keymap.set("n", "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { desc = "navigate up" })
    vim.keymap.set("n", "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { desc = "navigate right or tab" })
  '';
  type = "lua";
}
