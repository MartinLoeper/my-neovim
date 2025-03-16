{ pkgs, ... }: {
  plugin = pkgs.vimPlugins.harpoon2;
  config = ''
    local harpoon = require("harpoon")
    harpoon:setup({
      global_settings = {
        save_on_toggle = true,
      }
    })

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true, silent = true })

    vim.keymap.set("n", "<Leader>j", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<Leader>k", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<Leader>l", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<Leader>;", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end, { noremap = true, silent = true })
  '';
  type = "lua";
}
