{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.yanky-nvim;
  config = ''
    require("yanky").setup{
      ring = {
        history_length = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
        update_register_on_cycle = false,
        permanent_wrapper = nil,
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      ring = {
        ignore_registers = { "_" },
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 300,
      },
    }

    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
    vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

    vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

    vim.keymap.set("n", "<leader>fy", function()
      require("telescope").extensions.yank_history.yank_history()
    end, { noremap = true, silent = true, desc = "Open Yank History with Telescope" })
  '';
  type = "lua";
}
